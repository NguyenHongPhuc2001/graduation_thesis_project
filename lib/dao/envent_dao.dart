import 'package:graduation_thesis_project/model/Event.dart';

class EventDAO {
  Event ev_1 = Event(
    id: 1,
    endDate: DateTime.parse("2022-09-29"),
    createDate: DateTime.parse("2022-09-20"),
    eventName: "Event 1",
    status: false,
    totalSpending: 123000,
    wallet: null,
    urlImage: null,
  );

  Event ev_2 = Event(
    id: 2,
    endDate: DateTime.parse("2022-09-28"),
    createDate: DateTime.parse("2022-09-21"),
    eventName: "Event 2",
    status: false,
    totalSpending: 222000,
    wallet: null,
    urlImage: null,
  );
  Event ev_3 = Event(
    id: 3,
    endDate: DateTime.parse("2022-09-27"),
    createDate: DateTime.parse("2022-09-22"),
    eventName: "Event 3",
    status: false,
    totalSpending: 54233,
    wallet: null,
    urlImage: null,
  );
  Event ev_4 = Event(
    id: 4,
    endDate: DateTime.parse("2022-09-26"),
    createDate: DateTime.parse("2022-09-24"),
    eventName: "Event 4",
    status: true,
    totalSpending: 87111,
    wallet: null,
    urlImage: null,
  );
  List<Event> list = [];

  List<Event> getAllEvent() {
    list.add(ev_1);
    list.add(ev_2);
    list.add(ev_3);
    list.add(ev_4);
    return list;
  }

  void insertEvent(Event event) {
    list.add(event);
  }
}