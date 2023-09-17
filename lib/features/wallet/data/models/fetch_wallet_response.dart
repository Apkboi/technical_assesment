// To parse this JSON data, do
//
//     final fetchWalletResponse = fetchWalletResponseFromJson(jsonString);

import 'dart:convert';

FetchWalletResponse fetchWalletResponseFromJson(String str) => FetchWalletResponse.fromJson(json.decode(str));

String fetchWalletResponseToJson(FetchWalletResponse data) => json.encode(data.toJson());

class FetchWalletResponse {
  final bool success;
  final String message;
  final UserWallet userWallet;

  FetchWalletResponse({
    required this.success,
    required this.message,
    required this.userWallet,
  });

  FetchWalletResponse copyWith({
    bool? success,
    String? message,
    UserWallet? data,
  }) =>
      FetchWalletResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        userWallet: data ?? this.userWallet,
      );

  factory FetchWalletResponse.fromJson(Map<String, dynamic> json) => FetchWalletResponse(
    success: json["success"],
    message: json["message"],
    userWallet: UserWallet.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": userWallet.toJson(),
  };
}

class UserWallet {
  final String uuid;
  final int balance;
  final String userId;
  final String celebrityId;
  final String currency;
  final DateTime createdAt;

  UserWallet({
    required this.uuid,
    required this.balance,
    required this.userId,
    required this.celebrityId,
    required this.currency,
    required this.createdAt,
  });

  UserWallet copyWith({
    String? uuid,
    int? balance,
    String? userId,
    String? celebrityId,
    String? currency,
    DateTime? createdAt,
  }) =>
      UserWallet(
        uuid: uuid ?? this.uuid,
        balance: balance ?? this.balance,
        userId: userId ?? this.userId,
        celebrityId: celebrityId ?? this.celebrityId,
        currency: currency ?? this.currency,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    uuid: json["uuid"],
    balance: json["balance"],
    userId: json["userId"],
    celebrityId: json["celebrityId"],
    currency: json["currency"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "balance": balance,
    "userId": userId,
    "celebrityId": celebrityId,
    "currency": currency,
    "createdAt": createdAt.toIso8601String(),
  };
}
