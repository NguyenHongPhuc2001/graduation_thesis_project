import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/api/History_API.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';

import '../../../models/chart/pie_item.dart';


class PieItemController extends GetxController {

  Future<List?> getPieItems(String accountUsername, String date, String getDateType, String apiPaths) async {
    return await HistoryAPI().getPieItems(accountUsername, date, getDateType, apiPaths);
  }

}