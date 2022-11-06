bool isSameMonthYear(String monthYearString) {
    var strSplit = monthYearString.split("-");
    String year = strSplit[0];
    String month = strSplit[1];

    final now = DateTime.now();

    if (now.year.toInt() > int.parse(year)) {
      return false;
    } else if (now.year.toInt() == int.parse(year)) {
      if (now.month.toInt() >= int.parse(month)) {
        return false;
      }
      return true;
    } else {
      return true;
    }
}