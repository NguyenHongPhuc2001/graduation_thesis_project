import 'dart:convert';

String accountToJson(Account account) => json.encode(account);
Account accountFromJson(String str) => Account.fromJson(json.decode(str));

class Account {

  int? accountId;
  String accountUsername;
  String? accountPassword;
  String? newPassword;
  String? rePassword;

  Account({
    this.accountId,
    required this.accountUsername,
    this.accountPassword,
    this.newPassword,
    this.rePassword
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      accountId: json["accountId"],
      accountUsername: json["accountUsername"],
      accountPassword: json["accountPassword"],
      newPassword: json["newPassword"],
      rePassword: json["rePassword"]
  );

  Map<String, dynamic> toJson () => {
    "accountId" : accountId,
    "accountUsername" : accountUsername,
    "accountPassword" : accountPassword,
    "newPassword" : newPassword,
    "rePassword" : rePassword
  };

}