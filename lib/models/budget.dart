import 'dart:convert';

Budget budgetFromJson(String str) => Budget.fromJson(json.decode(str));
List<Budget> budgetsFromJson(List<dynamic> json) => List<Budget>.from(json.map((b) => Budget.fromJson(b))).toList();

String budgetToJson(Budget budget) => json.encode(budget);
String budgetsToJson(List<Budget> budgets) => json.encode(List<dynamic>.from(budgets.map((b) => b.toJson())));

class Budget {

  int? budgetId;
  String budgetName;
  String budgetIcon;
  double? budgetPresentValue;
  double budgetValue;
  String budgetMothYear;
  bool? budgetStatus;
  bool? budgetExpired;
  dynamic account;
  dynamic expense;
  List<dynamic>? histories;

  Budget({
    this.budgetId,
    required this.budgetName,
    required this.budgetIcon,
    this.budgetPresentValue,
    required this.budgetValue,
    required this.budgetMothYear,
    this.budgetStatus,
    this.budgetExpired,
    this.account,
    this.expense,
    this.histories
  });

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
      budgetId: json['budgetId'],
      budgetName: json['budgetName'],
      budgetIcon: json['budgetIcon'],
      budgetPresentValue: json['budgetPresentValue'],
      budgetValue: json['budgetValue'],
      budgetMothYear: json['budgetMothYear'],
      budgetStatus: json['budgetStatus'],
      budgetExpired: json['budgetExpired'],
      account: json['account'],
      expense: json['expense'],
      histories: json['histories']
  );

  Map<String, dynamic> toJson() => {
    "budgetId": budgetId,
    "budgetName": budgetName,
    "budgetIcon": budgetIcon,
    "budgetPresentValue": budgetPresentValue,
    "budgetValue": budgetValue,
    "budgetMothYear": budgetMothYear,
    "budgetStatus": budgetStatus,
    "budgetExpired": budgetExpired,
    "account": account,
    "expense": expense,
    "histories": histories
  };
}
