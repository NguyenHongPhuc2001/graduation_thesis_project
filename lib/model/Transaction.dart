import 'Event.dart';
import 'RAP.dart';
import 'Wallet.dart';

class Transactions {
  int id;
  String transactionName;
  double transactionValue;
  DateTime createDate;
  RAP rap;
  String transactionNote;
  Wallet wallet;
  Event? event;

  Transactions({
    required this.id,
    required this.transactionName,
    required this.transactionNote,
    required this.transactionValue,
    required this.createDate,
    required this.rap,
    required this.wallet,
    this.event,
  });

  Transactions.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        transactionName = data["transactionName"],
        transactionNote = data["transactionNote"],
        transactionValue = data["transactionValue"],
        createDate = data["createDate"],
        rap = data["rap"],
        wallet = data["wallet"],
        event = data["event"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionName': transactionName,
      'transactionNote': transactionNote,
      'transactionValue': transactionValue,
      'createDate': createDate,
      'rap': rap,
      'wallet': wallet,
      'event': event,
    };
  }
}
