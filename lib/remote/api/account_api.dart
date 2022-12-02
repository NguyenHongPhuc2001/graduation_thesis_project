import 'package:graduation_thesis_project/models/token.dart';
import 'package:graduation_thesis_project/remote/api/base_api.dart';
import 'package:graduation_thesis_project/utils/api_paths/uri_container.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../utils/api_paths/api_paths.dart';

class AccountAPI extends BaseAPI {
  Future<bool?> changePassword(String? username, String? password,
      String? newPassword, String? rePassword) async {
    final queryParameters = {
      "accountUsername": username,
      "accountPassword": password,
      "newPassword": newPassword,
      "rePassword": rePassword
    };

    final request = http.Request(
        ApiPaths.METHOD_POST, UriContainer().uriChangePassword("account"));

    request.headers['content-type'] = 'application/json';
    request.headers['Authorization'] = (await manager.getAuthToken())!;
    request.body = jsonEncode(queryParameters);

    final streamedRequest = await request.send();
    final response = await http.Response.fromStream(streamedRequest);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool?> signIn(String? username, String password) async {
    final queryParameters = {"username": username, "password": password};

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriSignIn("account"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    Map<String, dynamic> data = jsonDecode(response.body);

    final Token token = Token.fromJson(data.entries.elementAt(2).value);

    manager.setAuthToken(token.token);
    manager.setUsername(username!);

    if (data.entries.elementAt(1).value == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> signUp(
      String? username, String password, String repassword) async {
    final queryParameters = {
      "accountUsername": username!,
      "accountPassword": password,
      "rePassword": repassword,
      "role": {
        "roleName": "ROLE_USER1"
      }
    };

    final request =
        http.Request(ApiPaths.METHOD_POST, UriContainer().uriSignUp("account"));

    request.headers['content-type'] = 'application/json';
    request.body = jsonEncode(queryParameters);

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    Map<String, dynamic> data = jsonDecode(response.body);

    final Token token = Token.fromJson(data.entries.elementAt(2).value);

    manager.setAuthToken(token.token);
    manager.setUsername(username!);

    if (data.entries.elementAt(1).value == 201) {
      return true;
    } else {
      return false;
    }
  }
}
