import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/api/Expense_API.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';


import '../../../models/account.dart';



class ExpenseController extends GetxController{

  List<Expense> expenseList = <Expense>[].obs;

  void getExpenses() async {
    List<Expense>? eList = await ExpenseAPI().getList();
    expenseList.assignAll(eList!);
  }

  Future<bool?> createExpense(String? expenseName, String? expenseType, String? expenseIcon) async {
    return await ExpenseAPI().create(expenseName, expenseType, expenseIcon);
  }

  Future<bool?> updateExpense(int? expenseId, String? expenseName, String? expenseType, String? expenseIcon) async {
    return await ExpenseAPI().update(expenseId, expenseName, expenseType, expenseIcon);
  }

  Future<bool?> deleteExpense(int? expenseId) async {
    return await ExpenseAPI().delete(expenseId);
  }

  Future<Expense?> getExpense(int expenseId) async {
    return await ExpenseAPI().getOne(expenseId);
  }


}