
import 'package:graduation_thesis_project/models/base/base_model.dart';

List<ListDaysHaveTransaction> listDaysHaveTransactionInMonthFromJson(List<dynamic> json) => List<ListDaysHaveTransaction>.from(json.map((p) => ListDaysHaveTransaction.fromJson(p))).toList();

class ListDaysHaveTransaction extends BaseModel{

  String date;


  ListDaysHaveTransaction({required this.date});

  factory ListDaysHaveTransaction.fromJson(Map<String, dynamic> json) => ListDaysHaveTransaction(
      date: json['date']
  );

  Map<String, dynamic> toJson () => {
    "date" : date
  };


}