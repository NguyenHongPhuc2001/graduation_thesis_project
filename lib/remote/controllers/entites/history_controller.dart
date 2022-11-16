

import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/history.dart';
import 'package:graduation_thesis_project/remote/api/History_API.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';

class HistoryController extends GetxController {

  List<History> historyList = <History>[].obs;

  Future<List?> getHistoriesByWithdraw(String accountUsername) async {
    return await HistoryAPI().getHistoriesByWithdraw(accountUsername);
  }

}