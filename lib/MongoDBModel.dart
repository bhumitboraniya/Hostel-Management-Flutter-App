// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  ObjectId id;
  String email;
  String fullName;
  String fromDate;
  String toDate;
  String reason;
  String roomcode;

  MongoDbModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.roomcode,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        email: json["email"],
        fullName: json["fullName"],
        // fromDate: Date.fromJson(json["fromDate"]),
        // toDate: Date.fromJson(json["toDate"]),
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        reason: json["reason"],
        roomcode: json["roomcode"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "email": email,
        "fullName": fullName,
        // "fromDate": fromDate.toJson(),
        // "toDate": toDate.toJson(),
        "fromDate": fromDate,
        "toDate": toDate,
        "reason": reason,
        "roomcode": roomcode,
      };
}

class Date {
  DateClass date;

  Date({
    required this.date,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateClass.fromJson(json["\u0024date"]),
      );

  Map<String, dynamic> toJson() => {
        "\u0024date": date.toJson(),
      };
}

class DateClass {
  String numberLong;

  DateClass({
    required this.numberLong,
  });

  factory DateClass.fromJson(Map<String, dynamic> json) => DateClass(
        numberLong: json["\u0024numberLong"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024numberLong": numberLong,
      };
}

class Id {
  String oid;

  Id({
    required this.oid,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}
