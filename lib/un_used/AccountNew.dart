// class AccountNew {
//   int? accountId;
//   String accountUsername;
//   String accountPassword;
//   String? createdDate;
//   String? updatedDate;
//
//   AccountNew({
//     required this.accountUsername,
//     required this.accountPassword,
//     this.accountId,
//     this.createdDate,
//     this.updatedDate,
//   });
//
//   AccountNew.fromJson(Map<String, dynamic> data)
//       : this.accountId = data['accountId'],
//         this.accountUsername = data['accountUsername'],
//         this.accountPassword = data['accountPassword'],
//         this.createdDate = data['createdDate'],
//         this.updatedDate = data['updatedDate'];
//
//   Map<String, dynamic> toJson() {
//     return {
//       'accountId': this.accountId,
//       'accountUsername': this.accountUsername,
//       'accountPassword': this.accountPassword,
//       'createdDate': this.createdDate,
//       'updatedDate': this.updatedDate,
//     };
//   }
// }
