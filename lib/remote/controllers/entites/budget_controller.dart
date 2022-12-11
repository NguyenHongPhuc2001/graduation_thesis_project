import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/api/budget_api.dart';

import '../../../models/budget.dart';
import '../../../models/expense.dart';



class BudgetController extends GetxController{

  Future<List<Budget>?> getBudgets() async {
    return await BudgetAPI().getList();
  }

  Future<bool?> createBudget(String budgetName, double budgetValue, String budgetIcon, String budgetMothYear, int expenseId) async {
    return await BudgetAPI().create(budgetName, budgetValue, budgetIcon, budgetMothYear, expenseId);
  }

  Future<bool?> updateBudget(int? budgetId, String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense) async {
    return await BudgetAPI().update(budgetId, budgetName, budgetValue, budgetIcon, budgetMothYear, expense);
  }

  Future<bool?> deleteBudget(int? budgetId) async {
    return await BudgetAPI().delete(budgetId);
  }

  Future<List<Budget>> getListByExpired(bool budgetExpired) async {
    return await BudgetAPI().getListByExpired(budgetExpired);
  }


}