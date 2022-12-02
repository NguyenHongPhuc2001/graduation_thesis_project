import 'dart:async';
import 'dart:convert';

import 'package:graduation_thesis_project/remote/api/base_api.dart';
import 'package:graduation_thesis_project/utils/api_paths/api_paths.dart';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';

import '../../models/chart/pie_item.dart';
import '../../models/history.dart';
import '../../models/response/list_days_have_transaction_in_month.dart';
import '../../models/response/response_model.dart';
import 'package:http/http.dart' as http;

class HistoryAPI extends BaseAPI {


  Future<List<History>?> getHistoriesByWithdraw() async {

    String? username = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {"accountUsername": username};

    final request = http.Request(ApiPaths.METHOD_GET,
        Uri.http("10.0.2.2:8989", ApiPaths.HISTORY_DOMAIN + ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_BAR_CHART));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';

    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    var completer = Completer<List<History>>();

    if (response.statusCode == 200) {

      Map<String, dynamic> data = jsonDecode(response.body);
      var map = Map.fromIterable(data['objectList'] as List);
      List<History> histories = historiesFromJson(map.keys.toList());
      completer.complete(histories);

    } else {
      completer.completeError("Could not get the data !");
    }

    return completer.future;
  }

  Future<List<PieItem>?> getPieItems(String accountUsername, String date,
      String getDateType, String apiPaths) async {
    final queryParameters = {
      "accountUsername": accountUsername,
      "date": date,
      "getDateType": getDateType
    };

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetList("history"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if (response.statusCode == 200) {
      ResponseModel model = responseModelFromJson(response.body);
      List<PieItem> pieItems = pieItemsFromJson(model.modelList!.toList());
      return pieItems;
    }

    return null;
  }

  Future<bool> createTransaction(
      String historyType,
      String historyNotedDate,
      String historyAction,
      double historyCost,
      String historyNote,
      int expenseId,
      int walletId,
      int? eventId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyType": historyType,
      "historyNotedDate": historyNotedDate,
      "historyAction": historyAction,
      "historyCost": historyCost,
      "historyNote": historyNote,
      "accountUsername": userName!,
      "walletId": walletId,
      "expense": {
        "expenseId":expenseId
      },
      "eventId": eventId
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriCreate("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);

    if (data.entries.elementAt(1) == 201) {
      return true;
    }

    return false;
  }

  Future<bool> updateTransaction(
      String? historyType,
      String? historyNotedDate,
      String? historyAction,
      double? historyCost,
      String? historyNote,
      int? expenseId,
      int? walletId,
      int? eventId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyType": historyType,
      "historyNotedDate": historyNotedDate,
      "historyAction": historyAction,
      "historyCost": historyCost,
      "historyNote": historyNote,
      "accountUsername": userName!,
      "walletId": walletId,
      "expense": {
        "expenseId":expenseId
      },
      "eventId": eventId
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriUpdate("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);

    if (data.entries.elementAt(1) == 200) {
      return true;
    }

    return false;
  }

  Future<bool> deleteTransaction(int historyId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {"historyId": historyId};

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriDelete("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);

    if (data.entries.elementAt(1) == 200) {
      return true;
    }

    return false;
  }

  Future<List<History>> getListTransactionByWeek(
      String startDate, String endDate) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "startDate": startDate,
      "endDate": endDate
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetListByWeek("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    var completer = Completer<List<History>>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      List<History> map =
          historiesFromJson(dataFromAPI.entries.elementAt(2).value);
      completer.complete(map);
    } else {
      completer.completeError("Could not get the transactions !");
    }

    return completer.future;
  }

  Future<List<History>?> getListTransactionByMonth(String month) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "month": month,
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetListByMonth("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      List<History> map =
          historiesFromJson(dataFromAPI.entries.elementAt(2).value);

      return map;
    } else {
      return null;
    }

  }

  Future<List<History>?> getListTransactionByDay(String day) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "day": day,
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetListByDay("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);


    if (dataFromAPI.entries.elementAt(1).value == 200) {
      List<History> map =
      historiesFromJson(dataFromAPI.entries.elementAt(2).value);


      return map;
    } else {
      return null;
    }

  }

  Future<List<ListDaysHaveTransactionInMonth>?> getListDaysHaveTransactionByMonth(String month) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "month": month,
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetListDayInMonth("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);



    if (dataFromAPI.entries.elementAt(1).value == 200) {
      List<ListDaysHaveTransactionInMonth> map =
      listDaysHaveTransactionInMonthFromJson(dataFromAPI.entries.elementAt(2).value);

      return map;
    } else {
      return null;
    }

  }


}
