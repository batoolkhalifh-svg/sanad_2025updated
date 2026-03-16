// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:sanad_2025/Utilities/extensions.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? instructorName;
  final String? email;
  final String? mobile;
  final String? photo;
  final String? detail;
  final String? token;
  final String? deviceToken;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.instructorName,
    this.email,
    this.mobile,
    this.photo,
    this.detail,
    this.token,
    this.deviceToken,
    this.updatedAt,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? instructorName,
    String? email,
    String? mobile,
    String? photo,
    String? detail,
    String? token,
    String? deviceToken,
    DateTime? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        instructorName: instructorName ?? this.instructorName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        photo: photo ?? this.photo,
        detail: detail ?? this.detail,
        token: token ?? this.token,
        deviceToken: deviceToken ?? this.deviceToken,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    instructorName: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    photo: json["photo"],
    detail: json["detail"],
    token: json["token"],
    deviceToken: json["device_token"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "name": instructorName,
    "email": email,
    "mobile": mobile,
    "photo": photo,
    "detail": detail,
    "token": token,
    "device_token": deviceToken,
    "updated_at": updatedAt?.toIso8601String(),
  };

  Map<String, String> toApiJson() => ({
    "first_name": firstName,
    "last_name": lastName,
    "name": instructorName,
    "email": email,
    "mobile": mobile,
    "detail": detail,
  }..removeAllEmpty()).dynamicMapToString();
}
