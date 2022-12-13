import 'package:get/get.dart';

import '../../api/account_api.dart';


class AccountController extends GetxController{

  Future<bool?> changePassword(String? password, String? newPassword, String? rePassword) async {
    return await AccountAPI().changePassword(password, newPassword, rePassword);
  }

  Future<bool?> signIn(String? username, String password) async {
    return await AccountAPI().signIn(username, password);
  }

  Future<bool?> signUp(String? username, String password, String repassword) async {
    return await AccountAPI().signUp(username, password, repassword);
  }

}