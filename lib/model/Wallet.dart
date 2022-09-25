class Wallet {
  int id;
  String walletName;
  double walletBlanace;
  DateTime createDate;
  DateTime updateDate;

  Wallet({
    required this.id,
    required this.walletName,
    required this.walletBlanace,
    required this.createDate,
    required this.updateDate,
  });

  Wallet.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        walletName = data["walletName"],
        walletBlanace = data["walletBlanace"],
        createDate = data["createDate"],
        updateDate = data["updateDate"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "walletName": walletName,
      "walletBalance": walletBlanace,
      "createDate": createDate,
      "updateDate": updateDate,
    };
  }
}
