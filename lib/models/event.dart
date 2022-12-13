import 'package:graduation_thesis_project/models/wallet.dart';

List<Event> eventsFromJson(List<dynamic> json) => List<Event>.from(json.map((w) => Event.fromJson(w))).toList();

class Event {
  int? eventId;
  String eventName;
  String eventEndDate;
  bool eventStatus;
  String eventIcon;
  List<dynamic>? histories;
  Wallet? wallet;

  Event({
    required this.eventName,
    required this.eventEndDate,
    this.eventStatus = false,
    required this.eventIcon,
    this.histories,
     this.wallet,
  });

  Event.fromJson(Map<String, dynamic> data)
      : eventId = data['eventId'],
        eventName = data['eventName'],
        eventEndDate = data['eventEndDate'],
        eventStatus = data['eventStatus'],
        eventIcon = data['eventIcon'],
        wallet = Wallet.fromJson(data['wallet']),
        histories = data['histories'];

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'eventEndDate': eventEndDate,
      'eventStatus': eventStatus,
      'eventIcon': eventIcon,
      'wallet': wallet,
      'histories': histories,
    };
  }
}
