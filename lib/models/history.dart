import 'dart:convert';

import 'package:graduation_thesis_project/models/expense.dart';
import 'package:intl/intl.dart';

import 'base/base_model.dart';

History historyFromJson(String str) => History.fromJson(json.decode(str));
List<History> historiesFromJson(List<dynamic> json) => List<History>.from(json.map((h) => History.fromJson(h))).toList();

String historyToJson(History history) => json.encode(history);
String historiesToJson(List<History> histories) => json.encode(List<dynamic>.from(histories.map((h) => h.toJson())));

DateFormat df = DateFormat("yyyy-MM-dd");

class History extends BaseModel{

  int? historyId;
  String historyType;
  String? historyNotedDate;
  String? historyAction;
  double? historyCost;
  String? historyNote;
  String accountUsername;
  int? walletId;
  int? eventId;
  Expense? expense;

  History ({this.historyId, required this.historyType, this.historyNotedDate,
    this.historyAction, this.historyCost, this.historyNote, required this.accountUsername,
    this.walletId, this.eventId, this.expense});

  factory History.fromJson(Map<String, dynamic> json) => History(
      historyId: json['historyId'],
      historyType: json['historyType'],
      historyNotedDate: json['historyNotedDate'],
      historyAction: json['historyAction'],
      historyCost: json['historyCost'],
      historyNote: json['historyNote'],
      accountUsername: json['accountUsername'],
      walletId: json['walletId'],
      eventId: json['eventId'],
      expense: Expense.fromJson(json['expense'])
  );

  Map<String, dynamic> toJson () => {
    "historyId" : historyId,
    "historyType" : historyType,
    "historyNotedDate" : historyNotedDate,
    "historyAction" : historyAction,
    "historyCost" : historyCost,
    "historyNote" : historyNote,
    "accountUsername" : accountUsername,
    "walletId" : walletId,
    "eventId" : eventId,
    "expense" : expense!.toJson().toString()
  };

}