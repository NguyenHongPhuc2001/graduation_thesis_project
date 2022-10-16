import 'Event.dart';
import 'RAP.dart';
import 'wallet.dart';

class Transactions {
  int id;
  double transactionValue;
  DateTime createDate;
  RAP rap;
  String transactionNote;
  Wallet wallet;
  Event? event;

  Transactions({
    required this.id,
    required this.transactionNote,
    required this.transactionValue,
    required this.createDate,
    required this.rap,
    required this.wallet,
    this.event,
  });

  Transactions.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        transactionNote = data["transactionNote"],
        transactionValue = data["transactionValue"],
        createDate = data["createDate"],
        rap = data["rap"],
        wallet = data["wallet"],
        event = data["event"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionNote': transactionNote,
      'transactionValue': transactionValue,
      'createDate': createDate,
      'rap': rap,
      'wallet': wallet,
      'event': event,
    };
  }
}
