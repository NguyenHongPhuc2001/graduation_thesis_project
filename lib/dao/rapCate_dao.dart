import 'package:graduation_thesis_project/models/RAPCategory.dart';

class RAPCategoryDAO {
  RAPCategory rct1 = RAPCategory(
      id: 1,
      rapCateName: "Chi tiêu hằng ngày",
      rapCateType: "Chi",
      rapCateUrlImage: "images/FoodIcon_1.svg");
  RAPCategory rct2 = RAPCategory(
      id: 2,
      rapCateName: "Sức khỏe",
      rapCateType: "Chi",
      rapCateUrlImage: "images/HappyIcon.svg");
  RAPCategory rct3 = RAPCategory(
      id: 3,
      rapCateName: "Di chuyển",
      rapCateType: "Chi",
      rapCateUrlImage: "images/HealthIcon_1.svg");
  RAPCategory rct4 = RAPCategory(
      id: 4,
      rapCateName: "Lương",
      rapCateType: "Thu",
      rapCateUrlImage: "images/HouseIcon_1.svg");

  List<RAPCategory> listRAPCate = [];

  List<RAPCategory> getAll() {
    listRAPCate.add(rct1);
    listRAPCate.add(rct2);
    listRAPCate.add(rct3);
    listRAPCate.add(rct4);
    return listRAPCate;
  }

  List<RAPCategory> getByRAPCateType(String type) {
    List<RAPCategory> rapcate = [];
    List<RAPCategory> list = RAPCategoryDAO().getAll();

    list.forEach((element) {
      if (element.rapCateType == type) rapcate.add(element);
    });
    return rapcate;
  }
}
