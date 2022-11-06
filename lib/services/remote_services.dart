import 'dart:convert';
import 'dart:math';

import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/models/chart/pie_item.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/models/response/response_model.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/utils/api.dart';

import 'package:http/http.dart' as http;

import '../models/account.dart';
import '../models/history.dart';

class RemoteService {

  Future<bool?> changePassword(String? username, String? password, String? newPassword, String? rePassword) async {

    final queryParameters = {
      "accountUsername" : username,
      "accountPassword" : password,
      "newPassword" : newPassword,
      "rePassword" : rePassword
    };

    final request = http.Request(
        'POST',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.ACCOUNT_DOMAIN + ApiPaths.ACCOUNT_CHANGE_PASSWORD)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<List<Wallet>?> getWallets(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
      'GET',
      Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.WALLET_DOMAIN + ApiPaths.MODEL_GET_LIST_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      List<Wallet> wallets = walletsFromJson(model.modelList!.toList());

      return wallets;

    }

    return null;
  }

  Future<bool?> updateWallet(int? walletId, String? walletName, String? walletBalance, Account? account) async{

    final queryParameters = {
      "walletId" : walletId,
      "walletName" : walletName,
      "walletBalance" : walletBalance,
      "account" : account
    };

    final request = http.Request(
      'PUT',
      Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.WALLET_DOMAIN + ApiPaths.MODEL_UPDATE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> deleteWallet(int? walletId) async {

    final queryParameters = {
      "walletId" : walletId
    };

    final request = http.Request(
      'DELETE',
      Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.WALLET_DOMAIN + ApiPaths.MODEL_DELETE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> createWallet(String? walletName, double? walletBalance, Account? account) async{

    final queryParameters = {
      "walletName" : walletName,
      "walletBalance" : walletBalance,
      "account" : account
    };

    final request = http.Request(
        'POST',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.WALLET_DOMAIN + ApiPaths.MODEL_CREATE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<Expense?> getExpense(int expenseId) async {

    final queryParameters = {
      "expenseId" : expenseId
    };

    final request = http.Request(
        'GET',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.EXPENSE_DOMAIN + ApiPaths.MODEL_GET_ONE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      Expense expenses = expenseFromJson(model.model);

      return expenses;

    }

    return null;
  }

  Future<List<Expense>?> getExpenses(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        'GET',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.EXPENSE_DOMAIN + ApiPaths.MODEL_GET_LIST_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      List<Expense> expenses = expensesFromJson(model.modelList!.toList());

      return expenses;

    }

    return null;
  }

  Future<bool?> createExpense(String? expenseName, String? expenseType, String? expenseIcon, Account? account) async{

    final queryParameters = {
      "expenseName" : expenseName,
      "expenseType" : expenseType,
      "expenseIcon" : expenseIcon,
      "isExpenseSystem" : false,
      "account" : account
    };

    final request = http.Request(
        'POST',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.EXPENSE_DOMAIN + ApiPaths.MODEL_CREATE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> updateExpense(int? expenseId, String? expenseName, String? expenseType, String? expenseIcon, Account? account) async{

    final queryParameters = {
      "expenseId" : expenseId,
      "expenseName" : expenseName,
      "expenseType" : expenseType,
      "expenseIcon" : expenseIcon,
      "isExpenseSystem" : false,
      "account" : account
    };

    final request = http.Request(
        'PUT',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.EXPENSE_DOMAIN + ApiPaths.MODEL_UPDATE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> deleteExpense(int? expenseId, Account? account) async{

    final queryParameters = {
      "expenseId" : expenseId,
      "account" : account
    };

    final request = http.Request(
        'DELETE',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.EXPENSE_DOMAIN + ApiPaths.MODEL_DELETE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> createBudget(String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense, Account? account) async{

    final queryParameters = {
      "budgetName" : budgetName,
      "budgetValue" : budgetValue,
      "budgetIcon" : budgetIcon,
      "budgetMothYear" : budgetMothYear,
      "expense" : expense,
      "account" : account
    };

    final request = http.Request(
        'POST',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.BUDGET_DOMAIN + ApiPaths.MODEL_CREATE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> updateBudget(int? budgetId, String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense, Account? account) async{

    final queryParameters = {
      "budgetId" : budgetId,
      "budgetName" : budgetName,
      "budgetValue" : budgetValue,
      "budgetIcon" : budgetIcon,
      "budgetMothYear" : budgetMothYear,
      "expense" : expense,
      "account" : account
    };

    final request = http.Request(
        'PUT',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.BUDGET_DOMAIN + ApiPaths.MODEL_UPDATE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> deleteBudget(int? budgetId, Account? account) async{

    final queryParameters = {
      "budgetId" : budgetId,
      "account" : account
    };

    final request = http.Request(
        'DELETE',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.BUDGET_DOMAIN + ApiPaths.MODEL_DELETE_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<List<Budget>?> getBudgets(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        'GET',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.BUDGET_DOMAIN + ApiPaths.MODEL_GET_LIST_DOMAIN)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      List<Budget> budgets = budgetsFromJson(model.modelList!.toList());

      return budgets;

    }

    return null;
  }

  Future<List<History>?> getHistoriesByWithdraw(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        'GET',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.HISTORY_DOMAIN + ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_BAR_CHART)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      List<History> histories = historiesFromJson(model.modelList!.toList());

      return histories;

    }

    return null;
  }

  Future<List<PieItem>?> getPieItems(String accountUsername, String date, String getDateType, String apiPaths) async {

    final queryParameters = {
      "accountUsername" : accountUsername,
      "date" : date,
      "getDateType" : getDateType
    };

    final request = http.Request(
        'GET',
        Uri.http(ApiPaths.BE_DOMAIN, ApiPaths.HISTORY_DOMAIN + apiPaths)
    );

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);



    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      List<PieItem> pieItems = pieItemsFromJson(model.modelList!.toList());
      return pieItems;

    }

    return null;
  }

}