import 'package:graduation_thesis_project/models/account.dart';

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
  dynamic? histories;


  Goal.fromJson(Map<String, dynamic> data)
      : this.goalId = data['goalId'],
        this.goalName = data['goalName'],
        this.goalStatus = data['goalStatus'],
        this.goalPresentCost = data['goalPresentCost'].toDouble(),
        this.goalFinalCost = data['goalFinalCost'],
        this.goalDepositCost = data['goalDepositCost'],
        this.goalStartDate = data['goalStartDate'],
        this.goalEndDate = data['goalEndDate'],
        this.goalIcon = data['goalIcon'],
        this.goalColor = data['goalColor'],
        this.walletId = data['walletId'],
        this.histories = data['histories'];

  Map<String, dynamic> toJson() {
    return {
      'goalId': this.goalId,
      'goalName': this.goalName,
      'goalStatus': this.goalStatus,
      'goalPresentCost': this.goalPresentCost,
      'goalFinalCost': this.goalFinalCost,
      'goalDepositCost': this.goalDepositCost,
      'goalStartDate': this.goalStartDate,
      'goalEndDate': this.goalEndDate,
      'goalIcon': this.goalIcon,
      'goalColor': this.goalColor,
      'walletId': this.walletId,
      'histories': this.histories,
    };
  }
}
