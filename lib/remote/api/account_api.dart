import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../utils/api_paths/api_paths.dart';

class AccountAPI{

  Future<bool?> changePassword(String? username, String? password, String? newPassword, String? rePassword) async {

    final queryParameters = {
      "accountUsername" : username,
      "accountPassword" : password,
      "newPassword" : newPassword,
      "rePassword" : rePassword
    };

    final request = http.Request(
        ApiPaths.METHOD_POST,
        UriContainer().uriChangePassword("account"));

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