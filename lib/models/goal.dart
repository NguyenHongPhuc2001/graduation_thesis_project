import 'package:graduation_thesis_project/models/account.dart';


List<Goal> goalsFromJson(List<dynamic> json) => List<Goal>.from(json.map((w) => Goal.fromJson(w))).toList();


class Goal {
  int goalId;
  String goalName;
  bool goalStatus;
  double goalPresentCost;
  double goalFinalCost;
  double? goalDepositCost;
  String goalStartDate;
  String goalEndDate;
  String goalIcon;
  String goalColor;
  Account? account;
  int? walletId;
  // ignore: unnecessary_question_mark
  dynamic? histories;


  Goal.fromJson(Map<String, dynamic> data)
      : goalId = data['goalId'],
        goalName = data['goalName'],
        goalStatus = data['goalStatus'],
        goalPresentCost = data['goalPresentCost'].toDouble(),
        goalFinalCost = data['goalFinalCost'],
        goalDepositCost = data['goalDepositCost'],
        goalStartDate = data['goalStartDate'],
        goalEndDate = data['goalEndDate'],
        goalIcon = data['goalIcon'],
        goalColor = data['goalColor'],
        walletId = data['walletId'],
        histories = data['histories'];

  Map<String, dynamic> toJson() {
    return {
      'goalId': goalId,
      'goalName': goalName,
      'goalStatus': goalStatus,
      'goalPresentCost': goalPresentCost,
      'goalFinalCost': goalFinalCost,
      'goalDepositCost': goalDepositCost,
      'goalStartDate': goalStartDate,
      'goalEndDate': goalEndDate,
      'goalIcon': goalIcon,
      'goalColor': goalColor,
      'walletId': walletId,
      'histories': histories,
    };
  }
}
