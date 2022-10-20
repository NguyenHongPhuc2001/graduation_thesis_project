import 'dart:convert';

import 'package:graduation_thesis_project/models/base/base_model.dart';
import 'package:graduation_thesis_project/utils/enums/history_action.dart';

import '../utils/enums/history_type.dart';

History historyFromJson(String str) => History.fromJson(json.decode(str));
List<History> historiesFromJson(List<dynamic> json) => List<History>.from(json.map((h) => History.fromJson(h))).toList();

String historyToJson(History history) => json.encode(history.toJson());
String historiesToJson(List<History> histories) => json.encode(List<dynamic>.from(histories.map((h) => h.toJson())));

class History extends BaseModel{

  int? historyId;
  HistoryType historyType;
  String? historyNotedDate;
  HistoryAction? historyAction;
  double? historyCost;
  String? historyNote;
  String accountUsername;
  int? walletId;
  int? eventId;
  int? expenseId;

  History ({this.historyId, required this.historyType, this.historyNotedDate,
    this.historyAction, this.historyCost, this.historyNote, required this.accountUsername,
    this.walletId, this.eventId, this.expenseId});

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
      expenseId: json['expenseId']
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
    "expenseId" : expenseId
  };

}