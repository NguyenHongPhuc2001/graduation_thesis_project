import 'RAP.dart';
import 'Wallet.dart';

class Budget {
  int id;
  double budgetValue;
  DateTime createDate;
  Wallet wallet;
  RAP rap;
  bool status;
  DateTime endDate;

  Budget({
    required this.id,
    required this.createDate,
    required this.wallet,
    required this.rap,
    required this.budgetValue,
    required this.status,
    required this.endDate,
  });

  Budget.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        createDate = data["createDate"],
        wallet = data["wallet"],
        rap = data["rap"],
        budgetValue = data["budgetValue"],
        status = data["status"],
        endDate = data["endDate"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budgetValue': budgetValue,
      'createDate': createDate,
      'wallet': wallet,
      'rap': rap,
      'status': status,
      'endDate': endDate,
    };
  }
}
