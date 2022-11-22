import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/api/budget_api.dart';

import '../../../models/budget.dart';
import '../../../models/expense.dart';



class BudgetController extends GetxController{

  List<Budget> budgetList = <Budget>[].obs;

  void getBudgets() async {
    List<Budget>? eList = await BudgetAPI().getList();
    budgetList.assignAll(eList!);
  }

  Future<bool?> createBudget(String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense) async {
    return await BudgetAPI().create(budgetName, budgetValue, budgetIcon, budgetMothYear, expense);
  }

  Future<bool?> updateBudget(int? budgetId, String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense) async {
    return await BudgetAPI().update(budgetId, budgetName, budgetValue, budgetIcon, budgetMothYear, expense);
  }

  Future<bool?> deleteBudget(int? budgetId) async {
    return await BudgetAPI().delete(budgetId);
  }

}