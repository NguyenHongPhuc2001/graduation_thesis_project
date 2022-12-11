import 'dart:async';

import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/api/Goal_API.dart';

import '../../../models/goal.dart';

class GoalController extends GetxController {
  Future<Goal> getOneGoal(int eventId) async {
    return await GoalAPI().getOne(eventId);
  }

  Future<List<Goal>> getListGoal() async {
    return await GoalAPI().getList();
  }

  Future<bool> createGoal(String goalName, double goalFinalCost,
      String goalEndDate, String goalColor, String goalIcon) async {
    return await GoalAPI()
        .create(goalName, goalFinalCost, goalEndDate, goalColor, goalIcon);
  }

  Future<bool> updateGoal(
      int goalId,
      String goalName,
      String goalIcon,
      String goalEndDate,
      double goalFinalCost,
      String goalColor,
      double? goalPresentCost,
      bool? goalStatus) async {
    return await GoalAPI().update(goalId, goalName, goalIcon, goalEndDate,
        goalFinalCost, goalColor, goalPresentCost!, goalStatus!);
  }

  Future<bool> deleteGoal(int eventId) async {
    return await GoalAPI().delete(eventId);
  }

  Future<List<Goal>> getByStatus(bool goalStatus)async{
    return await GoalAPI().getGoalsByStatus(goalStatus);
  }

  Future<bool> goalDepositCost(int goalId,int walletId,double goalDeposit)async{
    return await GoalAPI().goalDepositCost(goalId, walletId, goalDeposit);
  }
}
