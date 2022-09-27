import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Event.dart';

class EventDAO {
  Event ev_1 = Event(
    id: 1,
    endDate: DateTime.parse("2022-09-29"),
    createDate: DateTime.parse("2022-09-20"),
    eventName: "Event 1",
    status: false,
    totalSpending: 123000,
    wallet: WalletDAO().wl1,
    urlImage: "images/BookIcon.svg",
  );

  Event ev_2 = Event(
    id: 2,
    endDate: DateTime.parse("2022-09-28"),
    createDate: DateTime.parse("2022-09-21"),
    eventName: "Event 2",
    status: false,
    totalSpending: 222000,
    wallet: WalletDAO().wl2,
    urlImage: "images/BoxIcon.svg",
  );
  Event ev_3 = Event(
    id: 3,
    endDate: DateTime.parse("2022-09-27"),
    createDate: DateTime.parse("2022-09-22"),
    eventName: "Event 3",
    status: false,
    totalSpending: 54233,
    wallet: WalletDAO().wl3,
    urlImage: "images/CarIcon_1.svg",
  );
  Event ev_4 = Event(
    id: 4,
    endDate: DateTime.parse("2022-09-26"),
    createDate: DateTime.parse("2022-09-24"),
    eventName: "Event 4",
    status: true,
    totalSpending: 87111,
    wallet: WalletDAO().wl1,
    urlImage: "images/ClothIcon_1.svg",
  );
  List<Event> list = [];

  List<Event> getAllEvent() {
    list.add(ev_1);
    list.add(ev_2);
    list.add(ev_3);
    list.add(ev_4);
    return list;
  }

  bool insertEvent(Event event) {
    list.add(event);
    if (list.last != event)
      return false;
    else
      return true;
  }

  bool deleteEvent(int idEvent) {
    Event ev = list.elementAt(idEvent - 1);
    list.removeAt(idEvent - 1);
    if (list.elementAt(idEvent - 1) == ev)
      return false;
    else
      return true;
  }

  Event getEventByID(int idEv) {
    Event event = EventDAO().ev_1;
    List<Event> listEv = EventDAO().getAllEvent();
    listEv.forEach((element) {
      if (element.id == idEv) {
        event = element;
      }
    });
    return event;
  }

  void updateEvent(Event oldEv, Event newEv) {
    oldEv.eventName = newEv.eventName;
    oldEv.urlImage = newEv.urlImage;
    oldEv.wallet = newEv.wallet;
    oldEv.totalSpending = newEv.totalSpending;
    oldEv.endDate = newEv.endDate;
  }
}
