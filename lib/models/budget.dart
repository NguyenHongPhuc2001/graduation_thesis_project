import 'dart:convert';

import 'package:graduation_thesis_project/models/Account.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/models/history.dart';

Budget expenseFromJson(String str) => Budget.fromJson(json.decode(str));
List<Budget> expensesFromJson(List<dynamic> json) => List<Budget>.from(json.map((b) => Expense.fromJson(b))).toList();

String expenseToJson(Budget budget) => json.encode(budget);
String expensesToJson(List<Budget> budgets) => json.encode(List<dynamic>.from(budgets.map((b) => b.toJson())));

class Budget {

  int? budgetId;
  String budgetName;
  String budgetIcon;
  double budgetValue;
  String budgetMothYear;
  bool budgetStatus;
  Account? account;
  Expense? expense;
  List<History>? histories;

  Budget({
    this.budgetId,
    required this.budgetName,
    required this.budgetIcon,
    required this.budgetValue,
    required this.budgetMothYear,
    required this.budgetStatus,
    this.account,
    this.expense,
    this.histories
  });

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
      budgetId: json['budgetId'],
      budgetName: json['budgetName'],
      budgetIcon: json['budgetIcon'],
      budgetValue: json['budgetValue'],
      budgetMothYear: json['budgetMothYear'],
      budgetStatus: json['budgetStatus'],
      account: json['account'],
      expense: json['expense'],
      histories: json['histories']
  );

  Map<String, dynamic> toJson() => {
    "budgetId": budgetId,
    "budgetName": budgetName,
    "budgetIcon": budgetIcon,
    "budgetValue": budgetValue,
    "budgetMothYear": budgetMothYear,
    "budgetStatus": budgetStatus,
    "account": account,
    "expense": expense,
    "histories": histories
  };
}
