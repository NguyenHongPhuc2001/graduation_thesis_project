import 'package:graduation_thesis_project/dao/rapCate_dao.dart';
import 'package:graduation_thesis_project/models/RAP.dart';

class RAPDAO {
  RAP r1 = RAP(
    id: 1,
    rapName: "Ăn uống",
    rapUrlImage: 'images/FoodIcon_1.svg',
    rapCategory: RAPCategoryDAO().rct1,
  );

  RAP r2 = RAP(
    id: 2,
    rapName: "Nhiên liệu",
    rapUrlImage: "images/CarIcon_1.svg",
    rapCategory: RAPCategoryDAO().rct2,
  );

  RAP r3 = RAP(
    id: 3,
    rapName: "Hóa đơn internet",
    rapUrlImage: "images/ReceiptInternetIcon.svg",
    rapCategory: RAPCategoryDAO().rct3,
  );

  RAP r4 = RAP(
    id: 4,
    rapName: "Lương",
    rapUrlImage: "images/MoneyIcon_2.svg",
    rapCategory: RAPCategoryDAO().rct4,
  );

  RAP r5 = RAP(
    id: 5,
    rapName: "Thu nhập",
    rapUrlImage: "images/MoneyIcon_3.svg",
    rapCategory: RAPCategoryDAO().rct4,
  );

  List<RAP> listRAP = [];

  List<RAP> getAll(){
    listRAP.add(r1);
    listRAP.add(r2);
    listRAP.add(r3);
    listRAP.add(r4);
    listRAP.add(r5);
    return listRAP;
  }

}
