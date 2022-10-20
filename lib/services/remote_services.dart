import 'dart:convert';

import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/models/response/response_model.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/utils/api.dart';

import 'package:http/http.dart' as http;

import '../models/Account.dart';

class RemoteService {

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

}