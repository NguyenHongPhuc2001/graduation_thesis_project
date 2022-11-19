// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));
String responseToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel<T> {

  String message;
  int statusCode;
  T? model;
  List<T>? modelList;
  String createdTime;

  ResponseModel({
    required this.message,
    required this.statusCode,
    this.model,
    this.modelList,
    required this.createdTime
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
      message: json['message'],
      statusCode: json['statusCode'],
      model : json['object'],
      modelList: List<T>.from(json['objectList']),
      createdTime: json['createdTime'] as String
  );

  Map<String, dynamic> toJson() => {
    "message" : message,
    "statusCode" : statusCode,
    "object" : model,
    "objectList" : modelList,
    "createdTime" : createdTime
  };

}