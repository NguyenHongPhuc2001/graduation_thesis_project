import 'package:get/get.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';

import '../../models/chart/pie_item.dart';

class PieItemController extends GetxController {

  Future<List<PieItem>?> getPieItems(String accountUsername, String date, String getDateType, String apiPaths) async {
    return await RemoteService().getPieItems(accountUsername, date, getDateType, apiPaths);
  }

}