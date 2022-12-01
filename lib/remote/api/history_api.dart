import 'dart:convert';

import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/api/base_api.dart';
import 'package:graduation_thesis_project/utils/api_paths/api_paths.dart';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';

import '../../models/chart/pie_item.dart';
import '../../models/history.dart';
import '../../models/response/response_model.dart';
import 'package:http/http.dart' as http;
class HistoryAPI extends BaseAPI{

  Future<List<History>?> getHistoriesByWithdraw(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetList("history"));

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
        ApiPaths.METHOD_GET,
       UriContainer().uriGetList("history")
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



  Future<bool> createTransaction(String historyType,String historyNotedDate,String historyAction,
      double historyCost, String historyNote, int expenseId, int walletId, int? eventId)async{

    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyType":historyType,
      "historyNotedDate":historyNotedDate,
      "historyAction":historyAction,
      "historyCost":historyCost,
      "historyNote":historyNote,
      "accountUsername":userName!,
      "walletId":walletId,
      "expenseId":expenseId,
      "eventId":eventId
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriCreate("history")
    );

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);


    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);
    
    if(data.entries.elementAt(1) == 201){
      return true;
    }

    return false;

  }


  Future<bool> updateTransaction(String? historyType,String? historyNotedDate,String? historyAction,
      double? historyCost, String? historyNote, int? expenseId, int? walletId, int? eventId)async{

    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyType":historyType,
      "historyNotedDate":historyNotedDate,
      "historyAction":historyAction,
      "historyCost":historyCost,
      "historyNote":historyNote,
      "accountUsername":userName!,
      "walletId":walletId,
      "expenseId":expenseId,
      "eventId":eventId
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriUpdate("history")
    );

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);


    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);

    if(data.entries.elementAt(1) == 200){
      return true;
    }

    return false;

  }

  Future<bool> deleteTransaction(int historyId)async{

    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyId":historyId
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriDelete("history")
    );

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);


    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);

    if(data.entries.elementAt(1) == 200){
      return true;
    }

    return false;

  }
}