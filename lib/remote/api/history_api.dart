import 'dart:convert';

import 'package:graduation_thesis_project/utils/api_paths/api_paths.dart';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';

import '../../models/chart/pie_item.dart';
import '../../models/history.dart';
import '../../models/response/response_model.dart';
import 'package:http/http.dart' as http;
class HistoryAPI{

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



}