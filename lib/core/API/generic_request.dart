import '../API/request_method.dart';
import '../error/exceptions.dart';
import '../network/error_message_model.dart';

abstract interface class ModelValidation {
  String? validate();
}

class GenericRequest<T> {
  final T Function(Map<String, dynamic> json) fromMap;
  final RequestApi method;

  GenericRequest({required this.fromMap, required this.method});

  ServerException _errorModel(
      dynamic response, String statusMessage, ExpectType expectType) =>
      ServerException(
        errorMessageModel: ErrorMessageModel.parsing(
          modelName: T.toString(),
          expectType: expectType,
          requestApi: method,
          responseApi: response,
          statusMessage: statusMessage,
        ),
      );

  /// جلب كائن مفرد
  Future<T> getObject() async {
    final response = await _getResponseMap();
    if (response["data"] is! Map) {
      throw _errorModel(response, "data is not compatible with expected data", ExpectType.object);
    }
    try {
      final result = fromMap(response["data"]);
      if (result is ModelValidation) {
        final validateError = result.validate();
        if (validateError != null) throw _errorModel(response, validateError, ExpectType.object);
      }
      return result;
    } catch (e) {
      throw _errorModel(response, e.toString(), ExpectType.object);
    }
  }

  /// جلب قائمة عناصر
  Future<List<T>> getList() async {
    final response = await _getResponseMap();
    if (!(response["data"] is List || response["data"]["data"] is List)) {
      throw _errorModel(response, "data is not compatible with expected data", ExpectType.list);
    }
    final responseList = (response["data"] is List) ? response["data"] : response["data"]["data"];
    try {
      final resultList = List<T>.from(responseList.map((e) => fromMap(e)));
      for (var item in resultList) {
        if (item is ModelValidation) {
          final validateError = item.validate();
          if (validateError != null) throw _errorModel(response, validateError, ExpectType.list);
        }
      }
      return resultList;
    } catch (e) {
      throw _errorModel(response, e.toString(), ExpectType.list);
    }
  }

  /// جلب الرد الكامل
  Future<T> getResponse() async {
    final response = await _getResponseMap();
    try {
      final result = fromMap(response);
      if (result is ModelValidation) {
        final validateError = result.validate();
        if (validateError != null) throw _errorModel(response, validateError, ExpectType.other);
      }
      return result;
    } catch (e) {
      throw _errorModel(response, e.toString(), ExpectType.other);
    }
  }

  /// تنفيذ الطلب وإرجاع Map
  Future<Map<String, dynamic>> _getResponseMap() async {
    final Map<String, dynamic> response =
    method.body.isNotEmpty
        ? await method.request()
        : await method.requestJson();

    final message = response['message'] ?? response['msg'];

    if (message != null &&
        (message.toString().toLowerCase().contains('unauth'))) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 401,
          statusMessage: message.toString(),
          requestApi: method,
          responseApi: response,
        ),
      );
    }

    return response;
  }


}
