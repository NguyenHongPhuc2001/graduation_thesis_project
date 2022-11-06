import 'package:get/get.dart';

import '../../models/account.dart';
import '../../models/budget.dart';
import '../../models/expense.dart';
import '../../services/remote_services.dart';


class BudgetController extends GetxController{

  List<Budget> budgetList = <Budget>[].obs;

  void getBudgets() async {
    List<Budget>? eList = await RemoteService().getBudgets("ChuTT");
    budgetList.assignAll(eList!);
  }

  Future<bool?> createBudget(String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense, Account? account) async {
    return await RemoteService().createBudget(budgetName, budgetValue, budgetIcon, budgetMothYear, expense, account);
  }

  Future<bool?> updateExpense(int? budgetId, String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense, Account? account) async {
    return await RemoteService().updateBudget(budgetId, budgetName, budgetValue, budgetIcon, budgetMothYear, expense, account);
  }

  Future<bool?> deleteBudget(int? budgetId, Account? account) async {
    return await RemoteService().deleteBudget(budgetId, account);
  }

}