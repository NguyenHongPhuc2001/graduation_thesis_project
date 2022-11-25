import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:graduation_thesis_project/models/event.dart';
import 'package:graduation_thesis_project/remote/api/base_api.dart';
import 'package:http/http.dart' as http;
import '../../models/event.dart';
import '../../utils/api_paths/api_paths.dart';
import '../../utils/api_paths/uri_container.dart';

class EventAPI extends BaseAPI{

  Future<Event> getOne(int eventId) async {

    final queryParameters = {"eventId": eventId};

    final request = http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetOne("event"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(response.body);

    var completer = Completer<Event>();

    print(dataFromAPI.entries.elementAt(3).toString());

    final Event event = Event.fromJson(dataFromAPI.entries.elementAt(2).value);

    completer.complete(event);

    return completer.future;
  }

  Future<List<Event>> getList() async {

    String? username = await manager.getUsername();

    final queryParameters = {"accountUsername": username};

    final request =
        http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetList("event"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
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

  Future<String> create(String eventName, String eventIcon, String eventEndDate, int walletId) async {

    String? username = await manager.getUsername();

    final queryParameters = {
      "eventName": eventName,
      "eventEndDate": eventEndDate,
      "eventIcon": eventIcon,
      "account": {
        "accountUsername": username
      },
      "wallet": {
        "walletId": walletId
      }
    };

    final request = http.Request(ApiPaths.METHOD_POST, UriContainer().uriCreate("event"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    final dataFromAPI = jsonDecode(response.body);

    if (dataFromAPI.entries.elementAt(1).value == 201) {
      return "Create";
    } else {
      return "None";
    }
  }

  Future<String> update( int eventId, String eventName, String linkIcon, String eventEndDate, int walletId, bool status) async {

    final queryParameters = {
      "eventId": eventId,
      "eventName": eventName,
      "eventEndDate": eventEndDate,
      "eventIcon": linkIcon,
      "eventStatus": (status != null) ? status : false,
      "wallet": {
        "walletId": walletId
      }
    };

    final request = http.Request(ApiPaths.METHOD_PUT, UriContainer().uriUpdate("event"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    final dataFromAPI = jsonDecode(response.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return "Update";
    } else {
      return "None";
    }
  }

  Future<String> delete(int eventId) async {

    String? username = await manager.getUsername();

    final queryParameters = {
      "eventId": eventId,
      "account": {
        "accountUsername": username
      }
    };

    final request = http.Request(ApiPaths.METHOD_DELETE, UriContainer().uriDelete("event"));

    request.body = jsonEncode(queryParameters);
    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    final dataFromAPI = jsonDecode(response.body);

    if (dataFromAPI.entries.elementAt(1).value == 200) {
      return "Delete";
    } else {
      return "None";
    }
  }

  Future<List<Event>> getByStatus(bool eventStatus)async{

    String? userName = await manager.getUsername();
    String? token = await manager.getAuthToken();
    final queryParameters = {
      "eventStatus":eventStatus,
      "account": {
        "accountUsername":userName!
      }
    };

    final request =
    http.Request(ApiPaths.METHOD_GET, UriContainer().uriGetListByStatus("event"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final responeStream = await request.send();
    final respone = await http.Response.fromStream(responeStream);

    Map<String, dynamic> dataFromAPI = jsonDecode(respone.body);

    var completer = Completer<List<Event>>();
    var map = Map.fromIterable(dataFromAPI['objectList'] as List);
    List<Event> listEvents = eventsFromJson(map.keys.toList());

    if(dataFromAPI.entries.elementAt(1).value == 200) {
      completer.complete(listEvents);
    }else{
      completer.completeError("Could not get the data !");
    }

    return completer.future;
  }

}
