import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:graduation_thesis_project/remote/api/base_api.dart';

import '../../models/goal.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_paths/api_paths.dart';
import '../../utils/api_paths/uri_container.dart';

class GoalAPI extends BaseAPI {

  Future<Goal> getOne(int goalId) async {

    String? token = await manager.getAuthToken();
    String? userName = await manager.getUsername();

    final queryParameters = {"goalId": goalId};


    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetOne("goal"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    var completer = Completer<Goal>();
    if (dataFromAPI.entries.elementAt(1).value == 200) {
      final Goal goal =
          Goal.fromJson(dataFromAPI.entries.elementAt(2).value);
      completer.complete(goal);
    } else {
      completer.completeError("Could not get the data !");
    }

    return completer.future;
  }

  Future<List<Goal>> getList() async {

    String? token = await manager.getAuthToken();
    String? userName = await manager.getUsername();
    final queryParameters = {"accountUsername": userName!};

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetList("goal"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    var completer = Completer<List<Goal>>();

    var map = Map.fromIterable(dataFromAPI['objectList'] as List);
    List<Goal> wallets = goalsFromJson(map.keys.toList());



    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(wallets);
    }else{
      completer.completeError("Could not get the data !");
    }

    return completer.future;
  }

  Future<bool> create(
      String goalName,
      double goalFinalCost,
      String goalEndDate,
      String goalColor,
      String goalIcon) async {


    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();


    final queryParameters = {
      "goalName": goalName,
      "goalFinalCost": goalFinalCost,
      "goalEndDate": goalEndDate,
      "goalColor": goalColor,
      "goalIcon": goalIcon,
      "account": {"accountUsername": userName!}
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriCreate("goal"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    if (dataFromAPI.entries.elementAt(1).value == 201)
      return true;
    else
      return false;
  }

  Future<bool> update(
      int goalId,
      String goalName,
      String goalIcon,
      String goalEndDate,
      double goalFinalCost,
      String goalColor,
      double? goalPresentCost,
      bool? goalStatus) async {


    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "goalId": goalId,
      "goalName": goalName,
      "goalPresentCost": goalPresentCost,
      "goalFinalCost": goalFinalCost,
      "goalEndDate": goalEndDate,
      "goalColor": goalColor,
      "goalIcon": goalIcon,
      "goalStatus":goalStatus,
      "account": {"accountUsername": userName!}
    };

    final request =
        http.Request(ApiPaths.METHOD_PUT, UriContainer().uriUpdate("goal"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return true;
    } else
      return false;
  }

  Future<bool> delete(int goalId) async {

    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();

    final queryParameters = {
      "goalId": goalId,
      "account": {"accountUsername": userName!}
    };

    final request =
        http.Request(ApiPaths.METHOD_DELETE, UriContainer().uriDelete("goal"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return true;
    } else
      return false;
  }


  Future<List<Goal>> getGoalsByStatus(bool goalStatus)async{

    String? token = await manager.getAuthToken();
    String? userName = await manager.getUsername();

    final queryParameters = {
      "goalStatus":goalStatus,
      "account": {
        "accountUsername":userName!
      }
    };

    final request =
    http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetListByStatus("goal"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    
    var completer = Completer<List<Goal>>();

    var map = Map.fromIterable(dataFromAPI['objectList'] as List);
    List<Goal> goals = goalsFromJson(map.keys.toList());

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(goals);
    }else{
      completer.completeError("Could not get the data !");
    }

    return completer.future;
  }
}
