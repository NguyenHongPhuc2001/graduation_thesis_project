import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/models/RAPCategory.dart';
import 'package:graduation_thesis_project/views/page/transaction.dart';

class RAP {
  int id;
  String rapName;
  String rapUrlImage;
  RAPCategory rapCategory;

  RAP({
    required this.id,
    required this.rapName,
    required this.rapUrlImage,
    required this.rapCategory,
  });

  RAP.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        rapName = data["rapName"],
        rapUrlImage = data["rapUrlImage"],
        rapCategory = data["rapCategory"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rapName': rapName,
      'rapUrlImage': rapUrlImage,
      'rapCategory': rapCategory,
    };
  }
}
