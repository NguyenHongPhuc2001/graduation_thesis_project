import 'package:graduation_thesis_project/models/base/base_model.dart';


List<TotalCost> totalCostsFromJson(List<dynamic> json) => List<TotalCost>.from(json.map((w) => TotalCost.fromJson(w))).toList();


class TotalCost extends BaseModel {

  double totalCost;

  TotalCost({
    required this.totalCost,
  });

  factory TotalCost.fromJson(Map<String, dynamic> json) =>
      TotalCost(totalCost: json['totalCost'] == null ? 0.0 : json['price'].toDouble());

  Map<String, dynamic> toJson() => {"totalCost": totalCost};
}
