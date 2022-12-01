import 'api_paths.dart';

class UriContainer {

  Uri uriGetList(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/${path}/${ApiPaths.MODEL_GET_LIST_DOMAIN}");
    return uri;
  }

  Uri uriGetOne(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/${path}/${ApiPaths.MODEL_GET_ONE_DOMAIN}");
    return uri;
  }

  Uri uriCreate(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/${path}/${ApiPaths.MODEL_CREATE_DOMAIN}");
    return uri;
  }

  Uri uriDelete(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/${path}/${ApiPaths.MODEL_DELETE_DOMAIN}");
    return uri;
  }

  Uri uriUpdate(String path) {
    Uri uri = Uri.http(
        "10.0.2.2:8989", "/${path}/${ApiPaths.MODEL_UPDATE_DOMAIN}");
    return uri;
  }

  Uri uriChangePassword(String path){
    Uri uri = Uri.http("10.0.2.2:8989","/${path}/${ApiPaths.ACCOUNT_CHANGE_PASSWORD}");
    return uri;
  }

  Uri uriSignIn(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.ACCOUNT_SIGN_IN_DOMAIN}");
    return uri;
  }

  Uri uriSignUp(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.ACCOUNT_SIGN_UP_DOMAIN}");
    return uri;
  }

  Uri uriGetListByStatus(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.MODEL_GET_LIST_BY_STATUS}");
    return uri;
  }

  Uri uriGetListByMonth(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.HISTORY_GET_LIST_BY_MONTH}");
    return uri;
  }

  Uri uriGetListByWeek(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.HISTORY_GET_LIST_BY_WEEK}");
    return uri;
  }

  Uri uriGetListByDay(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.HISTORY_GET_LIST_BY_DAY}");
    return uri;
  }

  Uri uriGetListDayInMonth(String path){
    Uri uri = Uri.http("10.0.2.2:8989", "/${path}/${ApiPaths.HISTORY_GET_LIST_DAY_IN_MONTH}");
    return uri;
  }

}

