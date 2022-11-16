import 'dart:async';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../models/goal.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_paths/api_paths.dart';
import '../../utils/api_paths/uri_container.dart';

class GoalAPI {
  Future<Goal> getOne(int goalId) async {
    final queryParameters = {"goalId": goalId};

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetOne("goal"));

    request.headers['content-type'] = 'application/json';
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

  Future<List<Goal>> getList(
      String accountUsername) async {
    final queryParameters = {"accountUsername": accountUsername};

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetList("goal"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    var completer = Completer<List<Goal>>();
    final List<Goal> listGoal = [];

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      dataFromAPI.entries.elementAt(2).value.forEach((item) {
        listGoal.add(Goal.fromJson(item));
      });
      completer.complete(listGoal);
    } else {
      completer.completeError("Could not get the data !");
    }

    return completer.future as List<Goal>;
  }

  Future<String> create(
      String goalName,
      double goalFinalCost,
      String goalEndDate,
      String goalColor,
      String goalIcon,
      String accountUsername) async {
    final queryParameters = {
      "goalName": goalName,
      "goalFinalCost": goalFinalCost,
      "goalEndDate": goalEndDate,
      "goalColor": goalColor,
      "goalIcon": goalIcon,
      "account": {"accountUsername": accountUsername}
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriCreate("goal"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    if (dataFromAPI.entries.elementAt(1).value == 201)
      return "Create";
    else
      return "None";
  }

  Future<String> update(
      int goalId,
      String goalName,
      String goalIcon,
      String goalEndDate,
      double goalFinalCost,
      String goalColor,
      double goalPresentCost,
      String accountUsername) async {
    final queryParameters = {
      "goalId": goalId,
      "goalName": goalName,
      "goalPresentCost": goalPresentCost,
      "goalFinalCost": goalFinalCost,
      "goalEndDate": goalEndDate,
      "goalColor": goalColor,
      "goalIcon": goalIcon,
      "account": {"accountUsername": accountUsername}
    };

    final request =
        http.Request(ApiPaths.METHOD_PUT, UriContainer().uriUpdate("goal"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return "Update";
    } else
      return "None";
  }

  Future<String> delete(int goalId, String accountUsername) async {
    final queryParameters = {
      "goalId": goalId,
      "account": {"accountUsername": accountUsername}
    };

    final request =
        http.Request(ApiPaths.METHOD_DELETE, UriContainer().uriDelete("goal"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return "Delete";
    } else
      return "None";
  }
}
