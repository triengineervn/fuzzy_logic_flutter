// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

List<Data> dataFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  dynamic v1;
  dynamic v2;
  String dateTime;

  Data({
    required this.v1,
    required this.v2,
    required this.dateTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        v1: json["V1"],
        v2: json["V2"],
        dateTime: json["DateTime"],
      );

  Map<String, dynamic> toJson() => {
        "V1": v1,
        "V2": v2,
        "DateTime": dateTime,
      };
}
