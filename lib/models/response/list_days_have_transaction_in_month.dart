
import 'package:graduation_thesis_project/models/base/base_model.dart';

List<ListDaysHaveTransactionInMonth> listDaysHaveTransactionInMonthFromJson(List<dynamic> json) => List<ListDaysHaveTransactionInMonth>.from(json.map((p) => ListDaysHaveTransactionInMonth.fromJson(p))).toList();

class ListDaysHaveTransactionInMonth extends BaseModel{

  String date;


  ListDaysHaveTransactionInMonth({required this.date});

  factory ListDaysHaveTransactionInMonth.fromJson(Map<String, dynamic> json) => ListDaysHaveTransactionInMonth(
      date: json['date']
  );

  Map<String, dynamic> toJson () => {
    "date" : date
  };


}