import 'dart:async';
import 'dart:convert';

import 'package:graduation_thesis_project/models/chart/bar_item.dart';
import 'package:graduation_thesis_project/models/response/total_cost.dart';
import 'package:graduation_thesis_project/remote/api/base_api.dart';
import 'package:graduation_thesis_project/utils/api_paths/api_paths.dart';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';

import '../../models/chart/pie_item.dart';
import '../../models/history.dart';
import '../../models/response/list_days_have_transaction.dart';
import '../../models/response/response_model.dart';
import 'package:http/http.dart' as http;

class HistoryAPI extends BaseAPI {
  Future<List<History>?> getHistoriesByWithdraw() async {
    String? username = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {"accountUsername": username};

    final request = http.Request(
        ApiPaths.METHOD_GET,
        Uri.http(
            "10.0.2.2:8989",
            ApiPaths.HISTORY_DOMAIN +
                ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_BAR_CHART));

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

  Future<List<PieItem>?> getPieItems(
      String date, String getDateType, String apiPaths) async {
    String? username = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": username,
      "date": date,
      "getDateType": getDateType
    };

    final request = http.Request(ApiPaths.METHOD_GET,
        Uri.http("10.0.2.2:8989", ApiPaths.HISTORY_DOMAIN + apiPaths));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
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
      String historyNotedDate,
      double historyCost,
      String historyNote,
      int expenseId,
      int walletId,
      int? eventId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyNotedDate":historyNotedDate,
      "historyCost":historyCost,
      "historyNote":historyNote,
      "accountUsername":userName,
      "walletId":walletId,
      "expense":{
        "expenseId":expenseId
      },
      "eventId":(eventId==null)?null:eventId
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriCreate("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> data = jsonDecode(response.body);


    if (data.entries.elementAt(1).value == 201) {
      return true;
    }

    return false;
  }

  Future<bool> updateTransaction(
      int? historyId,
      String? historyNotedDate,
      double? historyCost,
      String? historyNote,
      int? expenseId,
      int? walletId,
      int? eventId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "historyId": historyId,
      "historyNote": historyNote,
      "historyNotedDate": historyNotedDate,
      "accountUsername": userName,
      "historyCost": historyCost,
      "walletId": walletId,
      "expense": {"expenseId": expenseId},
      "eventId": (eventId != null) ? eventId : null,
    };

    final request =
        http.Request(ApiPaths.METHOD_PUT, UriContainer().uriUpdate("history"));

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

  Future<List<History>?> getListTransactionByDate(
      String date, String getDateType) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "date": date,
      "getDateType": getDateType
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetListByDate("history"));

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

  Future<List<ListDaysHaveTransaction>?> getListDaysHaveTransactionByMonth(
      String month) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "date": month,
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetListDayInMonth("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    print(token);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      List<ListDaysHaveTransaction> map =
          listDaysHaveTransactionInMonthFromJson(
              dataFromAPI.entries.elementAt(2).value);

      return map;
    } else {
      return null;
    }
  }

  Future<TotalCost> getTotalCostOfWithdraw(
      String date, String getDateType) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName,
      "date": date,
      "getDateType": getDateType
    };

    final request = http.Request(ApiPaths.METHOD_GET,
        UriContainer().uriGetTotalCostOfWithdraw("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    TotalCost totalCost =
        TotalCost.fromJson(dataFromAPI.entries.elementAt(2).value);

    var completer = Completer<TotalCost>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(totalCost);
    } else {
      completer.completeError("Could not get the total cost !");
    }

    return completer.future;
  }

  Future<TotalCost> getTotalCostOfRecharge(
      String date, String getDateType) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName,
      "date": date,
      "getDateType": getDateType
    };

    final request = http.Request(ApiPaths.METHOD_GET,
        UriContainer().uriGetTotalCostOfRecharge("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    TotalCost totalCost =
        TotalCost.fromJson(dataFromAPI.entries.elementAt(2).value);

    var completer = Completer<TotalCost>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(totalCost);
    } else {
      completer.completeError("Could not get the total cost !");
    }

    return completer.future;
  }

  Future<List<ListDaysHaveTransaction>> getListDayHaveTransactionByEvent(
      String date, int eventId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName!,
      "date": date,
      "eventId": eventId
    };

    final request = http.Request(ApiPaths.METHOD_GET,
        UriContainer().uriGetListDayHaveTransactionByEvent("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    print(dataFromAPI.entries.elementAt(2).value);

    List<ListDaysHaveTransaction> listDaysHaveTransaction =
        listDaysHaveTransactionInMonthFromJson(
            dataFromAPI.entries.elementAt(2).value);

    var completer = Completer<List<ListDaysHaveTransaction>>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(listDaysHaveTransaction);
    } else {
      completer.completeError(
          "Could not get the list day have transaction by event !");
    }

    return completer.future;
  }

  Future<List<History>> getListTransactionByEvent(int eventId) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {"eventId": eventId, "accountUsername": userName!};

    final request = http.Request(ApiPaths.METHOD_GET,
        UriContainer().uriGetListTransactionByEvent("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    List<History> listHistory =
        historiesFromJson(dataFromAPI.entries.elementAt(2).value);

    var completer = Completer<List<History>>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(listHistory);
    } else {
      completer
          .completeError("Could not get list of the transaction by event !");
    }

    return completer.future;
  }

  Future<TotalCost> getTotalCostByEvent(
      int eventId, String historyAction) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "eventId": eventId,
      "accountUsername": userName!,
      "historyAction": historyAction
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetTotalByEvent("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    print(dataFromAPI.entries.elementAt(2).value);

    TotalCost totalCost =
        TotalCost.fromJson(dataFromAPI.entries.elementAt(2).value);

    var completer = Completer<TotalCost>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(totalCost);
    } else {
      completer.completeError("Could not get total cost by event !");
    }

    return completer.future;
  }

  Future<List<BarItem>> getTotalCostBetweenDate(String year, String month,
      String historyAction, String lastDayOfMonth) async {
    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "accountUsername": userName,
      "year": year,
      "month": month,
      "lastDayOfMonth": lastDayOfMonth,
      "historyAction": historyAction
    };

    final request = http.Request(
        ApiPaths.METHOD_GET, UriContainer().uriGetTotalBetweenDate("history"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    List<BarItem> barItems =
        barItemsFromJson(dataFromAPI.entries.elementAt(2).value);

    var completer = Completer<List<BarItem>>();

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(barItems);
    } else {
      completer.completeError("Could not get total cost between date !");
    }

    return completer.future;
  }
}
