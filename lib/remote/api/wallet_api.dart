import 'dart:async';
import 'dart:convert';

import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';
import 'package:http/http.dart' as http;

import '../../models/account.dart';
import '../../models/response/response_model.dart';
import '../../models/wallet.dart';
import '../../utils/api_paths/api_paths.dart';

class WalletAPI {

  Future<List<Wallet>?> getList(String accountUsername) async {

    final queryParameters = {
      "accountUsername" : accountUsername
    };

    final request = http.Request(
        ApiPaths.METHOD_GET,
        UriContainer().uriGetList("wallet"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){

      ResponseModel model = responseModelFromJson(response.body);
      List<Wallet> wallets = walletsFromJson(model.modelList!.toList());

      return wallets;

    }

    return null;
  }

  Future<bool?> update(int? walletId, String? walletName, String? walletBalance, Account? account) async{

    final queryParameters = {
      "walletId" : walletId,
      "walletName" : walletName,
      "walletBalance" : walletBalance,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_PUT,
        UriContainer().uriUpdate("wallet"));

    request.headers['content-type'] = 'application/json';
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

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }

  Future<bool?> create(String? walletName, double? walletBalance, Account? account) async{

    final queryParameters = {
      "walletName" : walletName,
      "walletBalance" : walletBalance,
      "account" : account
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriCreate("wallet"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if(response.statusCode == 200){
      return true;
    }

    return false;
  }


}
