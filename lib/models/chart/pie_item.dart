import 'dart:convert';

import 'package:graduation_thesis_project/models/base/base_model.dart';

List<PieItem> pieItemsFromJson(List<dynamic> json) => List<PieItem>.from(json.map((p) => PieItem.fromJson(p))).toList();

class PieItem extends BaseModel {

  String expenseName;
  double totalCost;

  PieItem({required this.expenseName, required this.totalCost});

  factory PieItem.fromJson(Map<String, dynamic> json) => PieItem(
    expenseName: json['expenseName'],
    totalCost: json['totalCost']
  );

  Map<String, dynamic> toJson () => {
    "expenseName" : expenseName,
    "totalCost" : totalCost
  };

}