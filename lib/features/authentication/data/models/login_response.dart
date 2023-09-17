// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final bool success;
  final String message;
  final Data data;

  LoginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  LoginResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      LoginResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String uuid;
  final String fullName;
  final String userName;
  final String email;
  final String type;
  final String token;
  final bool activeNotification;

  Data({
    required this.uuid,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.type,
    required this.token,
    required this.activeNotification,
  });

  Data copyWith({
    String? uuid,
    String? fullName,
    String? userName,
    String? email,
    String? type,
    String? token,
    bool? activeNotification,
  }) =>
      Data(
        uuid: uuid ?? this.uuid,
        fullName: fullName ?? this.fullName,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        type: type ?? this.type,
        token: token ?? this.token,
        activeNotification: activeNotification ?? this.activeNotification,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uuid: json["uuid"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        type: json["type"],
        token: json["token"],
        activeNotification: json["activeNotification"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "type": type,
        "token": token,
        "activeNotification": activeNotification,
      };
}
