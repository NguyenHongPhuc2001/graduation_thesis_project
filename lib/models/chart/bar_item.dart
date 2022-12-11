
List<BarItem> barItemsFromJson(List<dynamic> json) => List<BarItem>.from(json.map((w) => BarItem.fromJson(w))).toList();

class BarItem{
  double totalCost;
  String dateType;

  BarItem({required this.dateType, required this.totalCost});


  factory BarItem.fromJson(Map<String, dynamic> json) =>
      BarItem(totalCost: json['totalCost'],
      dateType: json['dateType']);

  Map<String, dynamic> toJson() => {"totalCost": totalCost,'dateType':dateType};

}