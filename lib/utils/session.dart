import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{

  // ignore: non_constant_identifier_names
  final String AUTH_TOKEN = "auth_token";
  // ignore: non_constant_identifier_names
  final String USERNAME = "username";

  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_TOKEN, token);
  }

  Future<void> setUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USERNAME, username);
  }

  Future<String?> getAuthToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_TOKEN);
  }

  Future<String?> getUsername() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERNAME);
  }

}