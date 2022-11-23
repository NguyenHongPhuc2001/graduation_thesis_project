import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/event.dart';

import '../../api/Event_API.dart';

class EventController extends GetxController {


  Future<Event> getOneEvent(int eventId)async {
    return await EventAPI().getOne(eventId);
  }

  Future<List<Event>> getListEvent()async {
    return await EventAPI().getList();
  }

  Future<String> createEvent(String eventName, String linkIcon, String eventEndDate,
      int walletId)async {
    return await EventAPI().create(eventName, linkIcon, eventEndDate, walletId);
  }

  Future<String> updateEvent(int eventId, String eventName, String linkIcon,
      String eventEndDate, int walletId, bool status) async {
    return await  EventAPI().update(eventId, eventName, linkIcon, eventEndDate, walletId, status);
  }

  Future<String> deleteEvent(int eventId)async {
    return await EventAPI().delete(eventId);
  }
}
