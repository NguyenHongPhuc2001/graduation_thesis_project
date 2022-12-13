import 'dart:async';
import 'dart:convert';

import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';
import 'package:http/http.dart' as http;

import '../../models/account.dart';
import '../../models/expense.dart';
import '../../utils/api_paths/api_paths.dart';
import 'base_api.dart';

class ExpenseAPI extends BaseAPI{

  Future<Expense> getOne(int expenseId) async {

    final queryParameters = {
      "expenseId" : expenseId
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetOne("expense"));

    String? token = await manager.getAuthToken();

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';

    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    var completer = Completer<Expense>();

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);


    if(dataFromAPI.entries.elementAt(1).value == 200){

      Expense expense = Expense.fromJson(dataFromAPI.entries.elementAt(2).value);

      completer.complete(expense);

    }else{
      completer.completeError("Could not get the data");
    }

    return completer.future;
  }

  Future<List<Expense>?> getList() async {

    String? username = await manager.getUsername();

    final queryParameters = {
      "accountUsername" : username
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetList("expense")
    );

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      Map<String, dynamic> data = jsonDecode(response.body);
      var map = Map.fromIterable(data['objectList'] as List);
      List<Expense> expenses = expensesFromJson(map.keys.toList());


      return expenses;

    }

    return null;
  }

  Future<bool?> create(String expenseName, String expenseType, String expenseIcon) async{

    String? username = await manager.getUsername();

    final queryParameters =
    {
      "expenseName":expenseName,
      "expenseType":expenseType,
      "expenseIcon":expenseIcon,
      "isExpenseSystem":false,
      "account" : {
        "accountUsername" : username
      }
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriCreate("expense")
    );

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 201){
      return true;
    }

    return false;
  }

  Future<bool?> update(int? expenseId, String? expenseName, String? expenseType, String? expenseIcon) async{

    String? username = await manager.getUsername();
    Account account = Account(accountUsername: username!);

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

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> delete(int? expenseId) async{

    String? username = await manager.getUsername();
    Account account = Account(accountUsername: username!);

    final queryParameters = {
      "expenseId" : expenseId,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_DELETE,
        UriContainer().uriDelete("expense"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }
}
