import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Utilities/shared_preferences.dart';
import '../error/exceptions.dart';
import '../network/error_message_model.dart';

class RequestApi {
  Uri uri;
  final Map<String, String> body;
  final Map<String, dynamic> bodyJson;
  final List<http.MultipartFile> files;
  final Map<String, String>? headers;
  final String method; // "GET" أو "POST"
  final bool auth;

  RequestApi.get({
    required String url,
    this.headers,
    this.auth = true,
  })  : method = "GET",
        uri = Uri.parse(url),
        body = {},
        bodyJson = {},
        files = [];

  RequestApi.post({
    required String url,
    required this.body,
    this.files = const [],
    this.headers,
    this.auth = true,
  })  : method = "POST",
        uri = Uri.parse(url),
        bodyJson = {};

  RequestApi.postJson({
    required String url,
    required this.bodyJson,
    this.headers,
    this.auth = true,
  })  : method = "POST",
        uri = Uri.parse(url),
        body = {},
        files = [];

  Uri get _uri => uri.replace(
    queryParameters: {
      ...uri.queryParameters,
      "lang": SharedPref.getLanguage(),
    },
  );

  Future<Map<String, dynamic>> request() async {
    debugPrint("Request URL: $_uri");

    bool useGet = method == "GET" && body.isEmpty && bodyJson.isEmpty;

    if (useGet) {
      var request = http.Request("GET", _uri);
      if (headers != null) request.headers.addAll(headers!);
      return await _ApiBaseHelper.httpSendRequest(request, this);
    } else {
      var request = http.MultipartRequest("POST", _uri);

      // إضافة الحقول المطلوبة تلقائيًا
      final deviceToken = await SharedPref.getDeviceToken();
      request.fields.addAll({
        ...body,
        "lang": SharedPref.getLanguage(),
        if (deviceToken != null) "device_token": deviceToken,
      });

      request.files.addAll(files);

      if (headers != null) request.headers.addAll(headers!);

      return await _ApiBaseHelper.httpSendRequest(request, this);
    }
  }

  Future<Map<String, dynamic>> requestJson() async {
    debugPrint("Request URL: $_uri");

    bool useGet = method == "GET" && body.isEmpty && bodyJson.isEmpty;

    if (useGet) {
      var request = http.Request("GET", _uri);
      if (headers != null) request.headers.addAll(headers!);
      return await _ApiBaseHelper.httpSendRequest(request, this);
    } else {
      var request = http.Request("POST", _uri);

      final deviceToken = await SharedPref.getDeviceToken();
      final Map<String, dynamic> data = {
        ...bodyJson,
        "lang": SharedPref.getLanguage(),
        if (deviceToken != null) "device_token": deviceToken,
      };

      request.body = json.encode(data);

      if (headers != null) request.headers.addAll(headers!);

      return await _ApiBaseHelper.httpSendRequest(request, this);
    }
  }
}

class _ApiBaseHelper {
  static Future<dynamic> httpSendRequest(
      http.BaseRequest request, RequestApi requestApi) async {
    http.StreamedResponse response;

    try {
      request.headers.addAll({
        'Accept': 'application/json',
        'lang': SharedPref.getLanguage(),
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
      });

      final token = await SharedPref.getToken();
      print("Token = $token");
      if (requestApi.auth && token != null && token.isNotEmpty) {
        request.headers['Authorization'] = "Bearer $token";
      }

      response = await request.send().timeout(const Duration(seconds: 60));
    } on SocketException {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: "No Internet Connection",
          requestApi: requestApi,
        ),
      );
    }

    return _returnResponse(response, requestApi);
  }

  static Future<dynamic> _returnResponse(
      http.StreamedResponse response, RequestApi requestApi) async {
    String resStream = await response.stream.bytesToString();
    Map<String, dynamic> jsonResponse = {};

    try {
      jsonResponse = jsonDecode(resStream) as Map<String, dynamic>;
    } catch (_) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode,
          requestApi: requestApi,
          responseApi: {"_RAW_RESPONSE_": resStream},
        ),
      );
    }

    if (response.statusCode == 200) {
      if (jsonResponse["status"] == false) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel(
            statusCode: response.statusCode,
            statusMessage: jsonResponse["msg"],
            requestApi: requestApi,
            responseApi: jsonResponse,
          ),
        );
      }
      return jsonResponse;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: jsonResponse["msg"],
          requestApi: requestApi,
          responseApi: jsonResponse,
        ),
      );
    }
  }
}
