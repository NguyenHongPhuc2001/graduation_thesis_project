import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/api/Goal_API.dart';

import '../../../models/goal.dart';

class GoalController extends GetxController{

  Future<Goal> getOneGoal(int eventId) async {
    return await GoalAPI().getOne(eventId);
  }

  Future<List<Goal>> getListGoal(String accountUsername)async {
    return await GoalAPI().getList(accountUsername);
  }

  Future<String> createGoal(String goalName,
      double goalFinalCost,
      String goalEndDate,
      String goalColor,
      String goalIcon,
      String accountUsername)async {
    return await GoalAPI().create(goalName, goalFinalCost, goalEndDate, goalColor, goalIcon, accountUsername);
  }

  Future<String> updateGoal(int goalId,
      String goalName,
      String goalIcon,
      String goalEndDate,
      double goalFinalCost,
      String goalColor,
      double goalPresentCost,
      String accountUsername)async {


    return await GoalAPI().update(goalId, goalName, goalIcon, goalEndDate, goalFinalCost, goalColor, goalPresentCost, accountUsername);
  }

  Future<String> deleteGoal(int eventId, String accountUsername) async {
    return await GoalAPI().delete(eventId, accountUsername);
  }

}