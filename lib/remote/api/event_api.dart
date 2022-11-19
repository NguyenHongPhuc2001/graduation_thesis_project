import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import '../../models/event.dart';
import '../../utils/api_paths/api_paths.dart';
import '../../utils/api_paths/uri_container.dart';

class EventAPI {

  Future<Event> getOne(int eventId) async {
    final queryParameters = {"eventId": eventId};

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetOne("event"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    var completer = Completer<Event>();
    final Event event =
        Event.fromJson(dataFromAPI.entries.elementAt(2).value);
    completer.complete(event);

    return completer.future;
  }

  Future<List<Event>> getList(String accountUsername) async {
    final queryParameters = {"accountUsername": accountUsername};

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetList("event"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    var completer = Completer<List<Event>>();
    final List<Event> listEvent = [];
    dataFromAPI.entries.elementAt(2).value.forEach((item) {
      listEvent.add(Event.fromJson(item));
    });

    completer.complete(listEvent);

    return completer.future;
  }

  Future<String> create(String eventName, String linkIcon, String eventEndDate,
      int walletId, String accountUsername) async {
    final queryParameters = {
      "eventName": eventName,
      "eventEndDate": eventEndDate,
      "eventIcon": linkIcon,
      "account": {"accountUsername": accountUsername},
      "wallet": {"walletId": walletId}
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriCreate("event"));

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
      int eventId,
      String eventName,
      String linkIcon,
      String eventEndDate,
      int walletId,
      String accountUsername,
      bool status) async {
    final queryParameters = {
      "eventId": eventId,
      "eventName": eventName,
      "eventEndDate": eventEndDate,
      "eventIcon": linkIcon,
      "eventStatus": (status != null) ? status : false,
      "wallet": {"walletId": walletId}
    };

    final request =
        http.Request(ApiPaths.METHOD_PUT, UriContainer().uriUpdate("event"));

    request.body = jsonEncode(queryParameters);
    request.headers['content-type'] = 'application/json';

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    final dataFromAPI = jsonDecode(respone.body);

    print(queryParameters.toString());
    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return "Update";
    } else
      return "None";
  }

  Future<String> delete(int eventId, String accountUsername) async {

    final queryParameters = {
      "eventId": eventId,
      "account": {"accountUsername": accountUsername}
    };

    final request =
        http.Request(ApiPaths.METHOD_DELETE, UriContainer().uriDelete("event"));

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
