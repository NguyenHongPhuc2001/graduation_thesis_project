class ApiPaths {
  static const String ACCOUNT_DOMAIN = "account";
  static const String WALLET_DOMAIN = "wallet";
  static const String EXPENSE_DOMAIN = "expense";
  static const String GOAL_DOMAIN = "goal";
  static const String BUDGET_DOMAIN = "budget";
  static const String EVENT_DOMAIN = "event";
  static const String HISTORY_DOMAIN = "history";

  static const String MODEL_CREATE_DOMAIN = "create";
  static const String MODEL_UPDATE_DOMAIN = "update";
  static const String MODEL_DELETE_DOMAIN = "delete";
  static const String MODEL_GET_ONE_DOMAIN = "get";
  static const String MODEL_GET_LIST_DOMAIN = "get_list";
  static const String MODEL_GET_LIST_BY_EXPIRED = "get_list_by_expired";


  static const String METHOD_GET = "GET";
  static const String METHOD_POST = "POST";
  static const String METHOD_PUT = "PUT";
  static const String METHOD_DELETE = "DELETE";

  static const String ACCOUNT_SIGN_IN_DOMAIN = "sign_in";
  static const String ACCOUNT_CHANGE_PASSWORD = "change_password";
  static const String ACCOUNT_SIGN_UP_DOMAIN = "create";


  static String GOAL_DEPOSIT_DOMAIN = "goal_deposit";

  static const String HISTORY_GET_LIST_BY_WITHDRAW_PIE_CHART = "/get_list_by_withdraw_pie";
  static const String HISTORY_GET_LIST_BY_RECHARGE_PIE_CHART = "/get_list_by_recharge_pie";
  static const String HISTORY_GET_LIST_BY_WITHDRAW_BAR_CHART = "/get_list_by_withdraw_bar";
  static const String HISTORY_GET_LIST_BY_EVENT = "get_list_by_event";
  static const String HISTORY_GET_LIST_DAY_BY_EVENT =  "get_list_day_by_event";
  static const String HISTORY_GET_LIST_BY_DATE = "get_list_by_date";
  static const String HISTORY_GET_LIST_DAY_IN_MONTH =  "get_list_day_in_month";
  static const String HISTORY_GET_TOTAL_COST_OF_WITHDRAW = "get_total_cost_of_withdraw";
  static const String HISTORY_GET_TOTAL_COST_OF_RECHARGE = "get_total_cost_of_recharge";
  static const String HISTORY_GET_TOTAL_COST_BY_EVENT = "get_total_cost_by_event";
  static const String HISTORY_GET_TOTAL_COST_BETWEEN_DATE = "get_total_cost_between_date";
}