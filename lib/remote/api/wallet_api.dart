import 'dart:async';
import 'dart:convert';

import 'package:graduation_thesis_project/remote/api/base_api.dart';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';
import 'package:http/http.dart' as http;

import '../../models/account.dart';
import '../../models/wallet.dart';
import '../../utils/api_paths/api_paths.dart';

class WalletAPI extends BaseAPI{

  Future<List<Wallet>?> getList() async {

    String? username = await manager.getUsername();
    final queryParameters = {
      "accountUsername" : username!
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetList("wallet"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      Map<String, dynamic> data = jsonDecode(response.body);
      var map = Map.fromIterable(data['objectList'] as List);
      List<Wallet> wallets = walletsFromJson(map.keys.toList());

      return wallets;

    }

    return null;
  }

  Future<bool?> update(int? walletId, String? walletName, double? walletBalance) async{

    String? username = await manager.getUsername();

    final queryParameters = {
      "walletId" : walletId,
      "walletName" : walletName,
      "walletBalance" : walletBalance,
      "account" : {
        "accountUsername":username!
      }
    };

    final request = http.Request(
        ApiPaths.METHOD_PUT,
        UriContainer().uriUpdate("wallet"));

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

  Future<bool?> deleteWallet(int? walletId) async {

    final queryParameters = {
      "walletId" : walletId
    };

    final request = http.Request(
        ApiPaths.METHOD_DELETE,
        UriContainer().uriDelete("wallet"));

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

  Future<bool?> create(String? walletName, double? walletBalance) async{

    String? username = await manager.getUsername();
    Account account = Account(accountUsername: username!);

    final queryParameters = {
      "walletName" : walletName,
      "walletBalance" : walletBalance,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriCreate("wallet"));

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

  Future<Wallet> getOne(int walletId) async {
    
    final queryParameters = {
      "walletId":walletId
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetOne("wallet"));

    String? token = await manager.getAuthToken();
    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${token!}';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    var completer = Completer<Wallet>();


    Map<String, dynamic> data = jsonDecode(response.body);

    Wallet wallet = Wallet.fromJson(data.entries.elementAt(2).value);


    if(response.statusCode == 200){
      completer.complete(wallet);
    }else{
      completer.completeError("Could not get the data !");
    }

    return completer.future;
  }


}
