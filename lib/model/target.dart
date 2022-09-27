class Target {
  int id;
  String targetName;
  double targetMoney;
  double currentMoney;
  DateTime endDate;
  DateTime createDate;
  String urlImage;
  bool status;

  Target({
    required this.id,
    required this.targetName,
    required this.targetMoney,
    required this.currentMoney,
    required this.createDate,
    required this.endDate,
    required this.urlImage,
    required this.status,
  });

  Target.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        targetName = data["targetName"],
        targetMoney = data["targetMoney"],
        currentMoney = data["currentMoney"],
        createDate = data["createDate"],
        endDate = data["endDate"],
        urlImage = data["urlImage"],
        status = data["status"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'targetName': targetName,
      'targetMoney': targetMoney,
      'currentMoney': currentMoney,
      'createDate': createDate,
      'endDate': endDate,
      'urlImage': urlImage,
      'status':status,
    };
  }
}
