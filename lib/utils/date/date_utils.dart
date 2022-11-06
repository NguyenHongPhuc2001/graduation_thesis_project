import 'package:intl/intl.dart';

class DateUtilsCustom {

  List<String> getDateOfWeek(DateTime date) {

    List<String> dateStr = [];

    if (DateFormat('EEEE').format(date) == 'Monday') {
      dateStr.add(date.toString().split(" ")[0]);
      for(int i = 0; i < 6; i++){
        dateStr.add(addDate(date));
        date = date.add(const Duration(days: 1));
      }
    } else{
       while(true){
         date = date.subtract(const Duration(days: 1));
         if(DateFormat('EEEE').format(date) == 'Monday'){
          break;
         }
       }
       dateStr.add(date.toString().split(" ")[0]);
       for(int i = 0; i < 6; i++){
         dateStr.add(addDate(date));
         date = date.add(const Duration(days: 1));
       }
    }

    return dateStr;
  }

  String subtractDate(DateTime date){
    return date.subtract(const Duration(days: 1)).toString().split(" ")[0];
  }

  String addDate(DateTime date){
    return date.add(const Duration(days: 1)).toString().split(" ")[0];
  }

}