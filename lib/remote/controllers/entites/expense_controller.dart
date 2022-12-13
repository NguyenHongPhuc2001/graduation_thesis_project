import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/api/Expense_API.dart';

class ExpenseController extends GetxController{

  Future<List<Expense>?> getExpenses() async {
    return await ExpenseAPI().getList();
  }

  Future<bool?> createExpense(String expenseName, String expenseType, String expenseIcon) async {
    return await ExpenseAPI().create(expenseName, expenseType, expenseIcon);
  }

  Future<bool?> updateExpense(int? expenseId, String? expenseName, String? expenseType, String? expenseIcon) async {
    return await ExpenseAPI().update(expenseId, expenseName, expenseType, expenseIcon);
  }

  Future<bool?> deleteExpense(int? expenseId) async {
    return await ExpenseAPI().delete(expenseId);
  }

  Future<Expense> getExpense(int expenseId) async {
    return await ExpenseAPI().getOne(expenseId);
  }

}