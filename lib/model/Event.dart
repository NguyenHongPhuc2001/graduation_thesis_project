import 'package:graduation_thesis_project/model/Wallet.dart';

class Event {
  int id;
  String eventName;
  DateTime createDate;
  DateTime endDate;
  double totalSpending;
  bool status;
  Wallet wallet;
  String urlImage;


  Event({
    required this.totalSpending,
    required this.id,
    required this.endDate,
    required this.createDate,
    required this.eventName,
    required this.status,
    required this.wallet,
    required this.urlImage,
  });



  Event.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        eventName = data["eventName"],
        createDate = data["createDate"],
        endDate = data["endDate"],
        status = data["status"],
        totalSpending = data["totalSpending"],
        wallet = data["wallet"],
        urlImage = data["urlImage"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'createDate': createDate,
      'endDate': endDate,
      'status': status,
      'totalSpending': totalSpending,
      'wallet': wallet,
      'urlImage': urlImage,
    };
  }
}
