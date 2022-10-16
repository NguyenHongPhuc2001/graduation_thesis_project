import 'dart:convert';

import 'package:graduation_thesis_project/models/base/base_model.dart';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));
List<Wallet> walletsFromJson(List<dynamic> json) => List<Wallet>.from(json.map((w) => Wallet.fromJson(w))).toList();

String walletToJson(Wallet wallet) => json.encode(wallet.toJson());
String walletsToJson(List<Wallet> wallets) => json.encode(List<dynamic>.from(wallets.map((w) => w.toJson())));

class Wallet extends BaseModel{

  int? walletId;
  String? walletName;
  double? walletBalance;
  String? createdDate;
  String? updatedDate;

  Wallet({
    this.walletId,
    this.walletName,
    this.walletBalance,
    this.createdDate,
    this.updatedDate,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
      walletId: json['walletId'],
      walletName: json['walletName'],
      walletBalance: json['walletBalance'] as double,
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate']
  );

  Map<String, dynamic> toJson () => {
    "walletId" : walletId,
    "walletName" : walletName,
    "walletBalance" : walletBalance,
    "createdDate" : createdDate,
    "updatedDate" : updatedDate
  };

}
