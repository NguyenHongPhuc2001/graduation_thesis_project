import 'dart:convert';

import 'package:graduation_thesis_project/models/base/base_model.dart';

Expense expenseFromJson(String str) => Expense.fromJson(json.decode(str));
List<Expense> expensesFromJson(List<dynamic> json) => List<Expense>.from(json.map((e) => Expense.fromJson(e))).toList();

String expenseToJson(Expense expense) => json.encode(expense);
String expensesToJson(List<Expense> expenses) => json.encode(List<dynamic>.from(expenses.map((e) => e.toJson())));

class Expense extends BaseModel {

  int? expenseId;
  String expenseName;
  String expenseType;
  String expenseIcon;
  bool? isExpenseSystem;
  List<dynamic>? histories;

  Expense({
    this.expenseId,
    required this.expenseName,
    required this.expenseType,
    required this.expenseIcon,
    this.isExpenseSystem,
    this.histories
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
      expenseId: json['expenseId'],
      expenseName: json['expenseName'],
      expenseType: json['expenseType'],
      expenseIcon: json['expenseIcon'],
      isExpenseSystem: json['isExpenseSystem'],
      histories:  json['histories']
  );

  Map<String, dynamic> toJson () => {
      "expenseId": expenseIcon,
      "expenseName": expenseName,
      "expenseType": expenseType,
      "expenseIcon": expenseIcon,
      "isExpenseSystem": isExpenseSystem,
      "histories": histories
  };

}