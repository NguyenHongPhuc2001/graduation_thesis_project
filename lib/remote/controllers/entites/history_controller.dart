

import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/history.dart';
import 'package:graduation_thesis_project/remote/api/History_API.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';

class HistoryController extends GetxController {

  List<History> historyList = <History>[].obs;

  Future<List?> getHistoriesByWithdraw(String accountUsername) async {
    return await HistoryAPI().getHistoriesByWithdraw(accountUsername);
  }

  Future<bool> createTransaction(String historyType,String historyNotedDate,String historyAction,
      double historyCost, String historyNote, int expenseId, int walletId, int? eventId)async{
    return await HistoryAPI().createTransaction(historyType, historyNotedDate, historyAction, historyCost, historyNote, expenseId, walletId, eventId);
  }

  Future<bool> updateTransaction(String? historyType,String? historyNotedDate,String? historyAction,
      double? historyCost, String? historyNote, int? expenseId, int? walletId, int? eventId) async {
    return await HistoryAPI().updateTransaction(historyType,historyNotedDate,historyAction,
        historyCost,  historyNote,  expenseId,  walletId, eventId);
  }

  Future<bool> deleteTransaction(int historyId) async{
    return await HistoryAPI().deleteTransaction(historyId);
  }

}