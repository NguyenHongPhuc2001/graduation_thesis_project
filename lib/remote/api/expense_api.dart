import 'dart:async';
import 'dart:convert';

import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';
import 'package:http/http.dart' as http;

import '../../models/account.dart';
import '../../models/expense.dart';
import '../../models/response/response_model.dart';
import '../../utils/api_paths/api_paths.dart';


class ExpenseAPI {

  Future<Expense?> getOne(int expenseId) async {

    final queryParameters = {
      "expenseId" : expenseId
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetOne("expense"));

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

  Future<List<Expense>?> getList(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetOne("expense")
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

  Future<bool?> create(String? expenseName, String? expenseType, String? expenseIcon, Account? account) async{

    final queryParameters = {
      "expenseName" : expenseName,
      "expenseType" : expenseType,
      "expenseIcon" : expenseIcon,
      "isExpenseSystem" : false,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriCreate("expense")
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

  Future<bool?> update(int? expenseId, String? expenseName, String? expenseType, String? expenseIcon, Account? account) async{

    final queryParameters = {
      "expenseId" : expenseId,
      "expenseName" : expenseName,
      "expenseType" : expenseType,
      "expenseIcon" : expenseIcon,
      "isExpenseSystem" : false,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.MODEL_UPDATE_DOMAIN,
        UriContainer().uriUpdate("expense")
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

  Future<bool?> delete(int? expenseId, Account? account) async{

    final queryParameters = {
      "expenseId" : expenseId,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_DELETE,
        UriContainer().uriDelete("expense"));

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
