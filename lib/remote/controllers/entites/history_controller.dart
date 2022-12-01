import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/history.dart';
import 'package:graduation_thesis_project/remote/api/History_API.dart';

import '../../../models/response/list_days_have_transaction_in_month.dart';

class HistoryController extends GetxController {

  List<History> historyList = <History>[].obs;

  Future<List<History>?> getHistoriesByWithdraw() async {
    return await HistoryAPI().getHistoriesByWithdraw();
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


  Future<List<History>?> getListTransactionByMonth(String month)async{
    return await HistoryAPI().getListTransactionByMonth(month);
  }

  Future<List<History>?> getListTransactionByDay(String day)async{
    return await HistoryAPI().getListTransactionByDay(day);
  }

  Future<List<ListDaysHaveTransactionInMonth>?> getListDaysHaveTransactionByMonth(String month)async{
    return await HistoryAPI().getListDaysHaveTransactionByMonth(month);
  }

}