import 'api_paths.dart';

class UriContainer {

  Uri uriGetList(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/$path/${ApiPaths.MODEL_GET_LIST_DOMAIN}");
    return uri;
  }

  Uri uriGetOne(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/$path/${ApiPaths.MODEL_GET_ONE_DOMAIN}");
    return uri;
  }

  Uri uriCreate(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/$path/${ApiPaths.MODEL_CREATE_DOMAIN}");
    return uri;
  }

  Uri uriDelete(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/$path/${ApiPaths.MODEL_DELETE_DOMAIN}");
    return uri;
  }

  Uri uriUpdate(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/$path/${ApiPaths.MODEL_UPDATE_DOMAIN}");
    return uri;
  }

  Uri uriChangePassword(String path){
    Uri uri = Uri.http("10.0.2.2:8989","/$path/${ApiPaths.ACCOUNT_CHANGE_PASSWORD}");
    return uri;
  }

  Uri uriSignIn(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.ACCOUNT_SIGN_IN_DOMAIN}");
    return uri;
  }

  Uri uriSignUp(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.ACCOUNT_SIGN_UP_DOMAIN}");
    return uri;
  }

  Uri uriGetListByExpired(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.MODEL_GET_LIST_BY_EXPIRED}");
    return uri;
  }


  Uri uriGetListByDate(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_LIST_BY_DATE}");
    return uri;
  }

  Uri uriGetListDayInMonth(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_LIST_DAY_IN_MONTH}");
    return uri;
  }

  Uri uriGetHistoriesByWithdrawBarChart(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_BAR_CHART}");
    return uri;
  }


  Uri uriGetTotalCostOfWithdraw(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_TOTAL_COST_OF_WITHDRAW}");
    return uri;
  }

  Uri uriGetTotalCostOfRecharge(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_TOTAL_COST_OF_RECHARGE}");
    return uri;
  }

  Uri uriGoalDeposit(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.GOAL_DEPOSIT_DOMAIN}");
    return uri;
  }

  Uri uriGetListDayHaveTransactionByEvent(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_LIST_DAY_BY_EVENT}");
    return uri;
  }

  Uri uriGetListTransactionByEvent(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_LIST_BY_EVENT}");
    return uri;
  }


  Uri uriGetTotalByEvent(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_TOTAL_COST_BY_EVENT}");
    return uri;
  }


  Uri uriGetTotalBetweenDate(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/$path/${ApiPaths.HISTORY_GET_TOTAL_COST_BETWEEN_DATE}");
    return uri;
  }

}

