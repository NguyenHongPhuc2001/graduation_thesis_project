import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/chart/bar_item.dart';
import 'package:graduation_thesis_project/models/history.dart';
import 'package:graduation_thesis_project/models/response/total_cost.dart';
import 'package:graduation_thesis_project/remote/api/History_API.dart';

import '../../../models/response/list_days_have_transaction.dart';

class HistoryController extends GetxController {

  List<History> historyList = <History>[].obs;

  Future<List<History>?> getHistoriesByWithdraw() async {
    return await HistoryAPI().getHistoriesByWithdraw();
  }

  Future<bool> createTransaction(String historyNotedDate,
      double historyCost, String historyNote, int expenseId, int walletId, int? eventId)async{
    return await HistoryAPI().createTransaction( historyNotedDate, historyCost, historyNote, expenseId, walletId, eventId);
  }

  Future<bool> updateTransaction(int? historyId,String? historyNotedDate,
      double? historyCost, String? historyNote, int? expenseId, int? walletId, int? eventId) async {
    return await HistoryAPI().updateTransaction(historyId,historyNotedDate, historyCost,  historyNote,  expenseId,  walletId, eventId);
  }

  Future<bool> deleteTransaction(int historyId) async{
    return await HistoryAPI().deleteTransaction(historyId);
  }


  Future<List<History>?> getListTransactionByDate(String date, String getDateType)async{
    return await HistoryAPI().getListTransactionByDate(date,getDateType);
  }

  Future<List<ListDaysHaveTransaction>?> getListDaysHaveTransactionByMonth(String month)async{
    return await HistoryAPI().getListDaysHaveTransactionByMonth(month);
  }


  Future<TotalCost> getTotalCostOfWithdraw(String date, String getDateType)async{
    return await HistoryAPI().getTotalCostOfWithdraw(date, getDateType);
  }

  Future<TotalCost> getTotalCostOfRecharge(String date, String getDateType)async{
    return await HistoryAPI().getTotalCostOfRecharge(date, getDateType);
  }


  Future<List<ListDaysHaveTransaction>> getListDayHaveTransactionByEvent(String date, int eventId)async{
    return await HistoryAPI().getListDayHaveTransactionByEvent(date,eventId);
  }

  Future<List<History>> getListTransactionByEvent( int eventId)async{
    return await HistoryAPI().getListTransactionByEvent(eventId);
  }

  Future<TotalCost> getTotalCostByEvent( int eventId, String historyAction)async{
    return await HistoryAPI().getTotalCostByEvent(eventId,historyAction);
  }

  Future<List<BarItem>> getTotalCostBetweenDate(String year,String month ,String historyAction,String lastDayOfMonth)async{
    return await HistoryAPI().getTotalCostBetweenDate(year,month,historyAction,lastDayOfMonth);
  }
}