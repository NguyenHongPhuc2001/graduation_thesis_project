import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';

import '../../models/account.dart';


class ExpenseController extends GetxController{

  List<Expense> expenseList = <Expense>[].obs;

  void getExpenses() async {
    List<Expense>? eList = await RemoteService().getExpenses("ChuTT");
    expenseList.assignAll(eList!);
  }

  Future<bool?> createExpense(String? expenseName, String? expenseType, String? expenseIcon, Account? account) async {
    return await RemoteService().createExpense(expenseName, expenseType, expenseIcon, account);
  }

  Future<bool?> updateExpense(int? expenseId, String? expenseName, String? expenseType, String? expenseIcon, Account? account) async {
    return await RemoteService().updateExpense(expenseId, expenseName, expenseType, expenseIcon, account);
  }

  Future<bool?> deleteExpense(int? expenseId, Account? account) async {
    return await RemoteService().deleteExpense(expenseId, account);
  }

  Future<Expense?> getExpense(int expenseId) async {
    return await RemoteService().getExpense(expenseId);
  }

}