import 'package:get/get.dart';

import '../../api/account_api.dart';


class AccountController extends GetxController{

  Future<bool?> changePassword(String? username, String? password, String? newPassword, String? rePassword) async {
    return await AccountAPI().changePassword(username, password, newPassword, rePassword);
  }

}