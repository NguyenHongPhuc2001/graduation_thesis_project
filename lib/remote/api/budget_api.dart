import 'dart:async';
import 'dart:convert';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';

import '../../models/account.dart';
import '../../models/budget.dart';
import '../../models/expense.dart';
import '../../models/response/response_model.dart';
import '../../utils/api_paths/api_paths.dart';
import 'package:http/http.dart' as http;
class BudgetAPI {

  Future<bool?> create(String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense, Account? account) async{

    final queryParameters = {
      "budgetName" : budgetName,
      "budgetValue" : budgetValue,
      "budgetIcon" : budgetIcon,
      "budgetMothYear" : budgetMothYear,
      "expense" : expense,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriCreate("budget"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }


  Future<bool?> update(int? budgetId, String? budgetName, double? budgetValue, String? budgetIcon, String? budgetMothYear, Expense? expense, Account? account) async{

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
        ApiPaths.METHOD_PUT,
        UriContainer().uriUpdate("budget"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }


  Future<bool?> delete(int? budgetId, Account? account) async{

    final queryParameters = {
      "budgetId" : budgetId,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_DELETE,
        UriContainer().uriDelete("budget"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }


  Future<List<Budget>?> getList(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetList("budget"));

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
}