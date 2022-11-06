import 'package:get/get.dart';

import '../../services/remote_services.dart';

class AccountController extends GetxController{

  Future<bool?> changePassword(String? username, String? password, String? newPassword, String? rePassword) async {
    return await RemoteService().changePassword(username, password, newPassword, rePassword);
  }

}