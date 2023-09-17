// To parse this JSON data, do
//
//     final fetchTransactionsResponse = fetchTransactionsResponseFromJson(jsonString);

import 'dart:convert';

FetchTransactionsResponse fetchTransactionsResponseFromJson(String str) =>
    FetchTransactionsResponse.fromJson(json.decode(str));

String fetchTransactionsResponseToJson(FetchTransactionsResponse data) =>
    json.encode(data.toJson());

class FetchTransactionsResponse {
  final bool success;
  final String message;
  final Data data;

  FetchTransactionsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  FetchTransactionsResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      FetchTransactionsResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory FetchTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      FetchTransactionsResponse(
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
  final List<Transaction> transactions;
  final int count;

  Data({
    required this.transactions,
    required this.count,
  });

  Data copyWith({
    List<Transaction>? transactions,
    int? count,
  }) =>
      Data(
        transactions: transactions ?? this.transactions,
        count: count ?? this.count,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: List<Transaction>.from(
            json["records"].map((x) => Transaction.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "records": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "count": count,
      };
}

class Transaction {
  final String uuid;
  final String reference;
  final int amount;
  final int fee;
  final String currency;
  final String? metadata;
  final String type;
  final String? source;
  final String? initiator;
  final String celebrityId;
  final String? bankDetailId;
  final String userId;
  final String status;
  final dynamic failureReason;
  final DateTime createdAtDateOnly;
  final DateTime createdAt;
  final Celebrity user;
  final Celebrity celebrity;
  final BankDetail? bankDetail;

  Transaction({
    required this.uuid,
    required this.reference,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.metadata,
    required this.type,
    required this.source,
    required this.initiator,
    required this.celebrityId,
    required this.bankDetailId,
    required this.userId,
    required this.status,
    required this.failureReason,
    required this.createdAtDateOnly,
    required this.createdAt,
    required this.user,
    required this.celebrity,
    required this.bankDetail,
  });

  Transaction copyWith({
    String? uuid,
    String? reference,
    int? amount,
    int? fee,
    String? currency,
    String? metadata,
    String? type,
    String? source,
    String? initiator,
    String? celebrityId,
    String? bankDetailId,
    String? userId,
    String? status,
    dynamic failureReason,
    DateTime? createdAtDateOnly,
    DateTime? createdAt,
    Celebrity? user,
    Celebrity? celebrity,
    BankDetail? bankDetail,
  }) =>
      Transaction(
        uuid: uuid ?? this.uuid,
        reference: reference ?? this.reference,
        amount: amount ?? this.amount,
        fee: fee ?? this.fee,
        currency: currency ?? this.currency,
        metadata: metadata ?? this.metadata,
        type: type ?? this.type,
        source: source ?? this.source,
        initiator: initiator ?? this.initiator,
        celebrityId: celebrityId ?? this.celebrityId,
        bankDetailId: bankDetailId ?? this.bankDetailId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        failureReason: failureReason ?? this.failureReason,
        createdAtDateOnly: createdAtDateOnly ?? this.createdAtDateOnly,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user,
        celebrity: celebrity ?? this.celebrity,
        bankDetail: bankDetail ?? this.bankDetail,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        uuid: json["uuid"],
        reference: json["reference"],
        amount: json["amount"],
        fee: json["fee"],
        currency: json["currency"],
        metadata: json["metadata"],
        type: json["type"],
        source: json["source"],
        initiator: json["initiator"],
        celebrityId: json["celebrityId"],
        bankDetailId: json["bankDetailId"],
        userId: json["userId"],
        status: json["status"],
        failureReason: json["failureReason"],
        createdAtDateOnly: DateTime.parse(json["createdAtDateOnly"]),
        createdAt: DateTime.parse(json["createdAt"]),
        user: Celebrity.fromJson(json["user"]),
        celebrity: Celebrity.fromJson(json["celebrity"]),
        bankDetail: json["bankDetail"] == null
            ? null
            : BankDetail.fromJson(json["bankDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "reference": reference,
        "amount": amount,
        "fee": fee,
        "currency": currency,
        "metadata": metadata,
        "type": type,
        "source": source,
        "initiator": initiator,
        "celebrityId": celebrityId,
        "bankDetailId": bankDetailId,
        "userId": userId,
        "status": status,
        "failureReason": failureReason,
        "createdAtDateOnly":
            "${createdAtDateOnly.year.toString().padLeft(4, '0')}-${createdAtDateOnly.month.toString().padLeft(2, '0')}-${createdAtDateOnly.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt.toIso8601String(),
        "user": user.toJson(),
        "celebrity": celebrity.toJson(),
        "bankDetail": bankDetail?.toJson(),
      };
}

class BankDetail {
  final String uuid;
  final String accountNumber;
  final String accountName;
  final String bankCode;
  final String bankName;
  final String userId;
  final bool isDeleted;
  final int isPrimary;
  final DateTime createdAt;
  final DateTime updatedAt;

  BankDetail({
    required this.uuid,
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.bankName,
    required this.userId,
    required this.isDeleted,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
  });

  BankDetail copyWith({
    String? uuid,
    String? accountNumber,
    String? accountName,
    String? bankCode,
    String? bankName,
    String? userId,
    bool? isDeleted,
    int? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      BankDetail(
        uuid: uuid ?? this.uuid,
        accountNumber: accountNumber ?? this.accountNumber,
        accountName: accountName ?? this.accountName,
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,
        userId: userId ?? this.userId,
        isDeleted: isDeleted ?? this.isDeleted,
        isPrimary: isPrimary ?? this.isPrimary,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
        uuid: json["uuid"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        userId: json["userId"],
        isDeleted: json["isDeleted"],
        isPrimary: json["isPrimary"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "bankCode": bankCode,
        "bankName": bankName,
        "userId": userId,
        "isDeleted": isDeleted,
        "isPrimary": isPrimary,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Celebrity {
  final String uuid;
  final String fullName;
  final String? userName;
  final String? occupation;
  final String? profileImagePath;
  final String email;
  final DateTime? dateOfBirth;
  final String? bio;
  final bool isEmailVerified;
  final String type;
  final bool activeNotification;
  final bool informationSubscription;
  final String eligibility;
  final DateTime createdAtDateOnly;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Celebrity({
    required this.uuid,
    required this.fullName,
    required this.userName,
    required this.occupation,
    required this.profileImagePath,
    required this.email,
    required this.dateOfBirth,
    required this.bio,
    required this.isEmailVerified,
    required this.type,
    required this.activeNotification,
    required this.informationSubscription,
    required this.eligibility,
    required this.createdAtDateOnly,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Celebrity copyWith({
    String? uuid,
    String? fullName,
    String? userName,
    String? occupation,
    String? profileImagePath,
    String? email,
    DateTime? dateOfBirth,
    String? bio,
    bool? isEmailVerified,
    String? type,
    bool? activeNotification,
    bool? informationSubscription,
    String? eligibility,
    DateTime? createdAtDateOnly,
    Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Celebrity(
        uuid: uuid ?? this.uuid,
        fullName: fullName ?? this.fullName,
        userName: userName ?? this.userName,
        occupation: occupation ?? this.occupation,
        profileImagePath: profileImagePath ?? this.profileImagePath,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        bio: bio ?? this.bio,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        type: type ?? this.type,
        activeNotification: activeNotification ?? this.activeNotification,
        informationSubscription:
            informationSubscription ?? this.informationSubscription,
        eligibility: eligibility ?? this.eligibility,
        createdAtDateOnly: createdAtDateOnly ?? this.createdAtDateOnly,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
        uuid: json["uuid"],
        fullName: json["fullName"],
        userName: json["userName"],
        occupation: json["occupation"],
        profileImagePath: json["profileImagePath"],
        email: json["email"]!,
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        bio: json["bio"],
        isEmailVerified: json["isEmailVerified"],
        type: json["type"],
        activeNotification: json["activeNotification"],
        informationSubscription: json["informationSubscription"],
        eligibility: json["eligibility"],
        createdAtDateOnly: DateTime.parse(json["createdAtDateOnly"]),
        status: statusValues.map[json["status"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "fullName": fullName,
        "userName": userName,
        "occupation": occupation,
        "profileImagePath": profileImagePath,
        "email": email,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "bio": bio,
        "isEmailVerified": isEmailVerified,
        "type": type,
        "activeNotification": activeNotification,
        "informationSubscription": informationSubscription,
        "eligibility": eligibilityValues.reverse[eligibility],
        "createdAtDateOnly":
            "${createdAtDateOnly.year.toString().padLeft(4, '0')}-${createdAtDateOnly.month.toString().padLeft(2, '0')}-${createdAtDateOnly.day.toString().padLeft(2, '0')}",
        "status": statusValues.reverse[status],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

enum Eligibility { PENDING }

final eligibilityValues = EnumValues({"PENDING": Eligibility.PENDING});

enum Status { ACTIVE }

final statusValues = EnumValues({"active": Status.ACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
