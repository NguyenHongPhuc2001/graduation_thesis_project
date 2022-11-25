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
      : this.eventId = data['eventId'],
        this.eventName = data['eventName'],
        this.eventEndDate = data['eventEndDate'],
        this.eventStatus = data['eventStatus'],
        this.eventIcon = data['eventIcon'],
        this.wallet = Wallet.fromJson(data['wallet']),
        this.histories = data['histories'];

  Map<String, dynamic> toJson() {
    return {
      'eventId': this.eventId,
      'eventName': this.eventName,
      'eventEndDate': this.eventEndDate,
      'eventStatus': this.eventStatus,
      'eventIcon': this.eventIcon,
      'wallet': this.wallet,
      'histories': this.histories,
    };
  }
}
