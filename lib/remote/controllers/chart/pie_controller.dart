import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/chart/pie_item.dart';
import 'package:graduation_thesis_project/remote/api/History_API.dart';


class PieItemController extends GetxController {

  Future<List<PieItem>?> getPieItems(String date, String getDateType, String apiPaths) async {
    return await HistoryAPI().getPieItems(date, getDateType, apiPaths);
  }

}