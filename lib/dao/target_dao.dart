import 'package:graduation_thesis_project/model/target.dart';

class TargetDAO {
  Target tg1 = Target(
    id: 1,
    targetName: "Target 1",
    targetMoney: 200000,
    currentMoney: 0,
    createDate: DateTime.now(),
    endDate: DateTime.now(),
    urlImage: "images/CalendarIcon_1.svg",
    status: false,
  );
  Target tg2 = Target(
    id: 2,
    targetName: "Target 2",
    targetMoney: 500000,
    currentMoney: 0,
    createDate: DateTime.now(),
    endDate: DateTime.now(),
    urlImage: "images/CalendarIcon_2.svg",
    status: false,
  );
  Target tg3 = Target(
    id: 3,
    targetName: "Target 3",
    targetMoney: 1200000,
    currentMoney: 0,
    createDate: DateTime.now(),
    endDate: DateTime.now(),
    urlImage: "images/CalendarIcon_3.svg",
    status: true,
  );
  Target tg4 = Target(
    id: 4,
    targetName: "Target 4",
    targetMoney: 805000,
    currentMoney: 0,
    createDate: DateTime.now(),
    endDate: DateTime.now(),
    urlImage: "images/CalendarIcon_4.svg",
    status: false,
  );

  List<Target> listTarget = [];

  List<Target> getAll() {
    listTarget.add(tg1);
    listTarget.add(tg2);
    listTarget.add(tg3);
    listTarget.add(tg4);
    return listTarget;
  }

  Target getTargetById(int id) {
    List<Target> list = TargetDAO().getAll();
    var target;
    list.forEach((element) {
      if (element.id == id) target = element;
    });
    return target as Target;
  }

  void updateTarget(Target oldTg, Target newTg) {
    oldTg = newTg;
  }
}
