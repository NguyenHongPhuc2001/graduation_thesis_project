import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_addEvent.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_end.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_happening.dart';

class EventScreen extends StatefulWidget {
  final PageController pageController;
  final List<Event> listEvent;
  final Event? event;
  final List<Transactions> listTransaction;

  const EventScreen({
    Key? key,
    required this.pageController,
    required this.listEvent,
    this.event,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _eventPageController = PageController();
  bool statusOfInsert = false;
  int nbBeforInsert = 0, nbAfterInsert = 0;
  List<Event> ls = [];

  @override
  Widget build(BuildContext context) {
    ls = widget.listEvent;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(size.width, size.width * 0.35),
            child: AppBarContainer(
              text: "Sự kiện",
              screenPageController: _eventPageController,
              pageController: widget.pageController,
              onTap: () async {
                final data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEvent(
                      listEvent: widget.listEvent,
                      status: statusOfInsert,
                    ),
                  ),
                ).then((value) => setState(() {
                  if (value == "Save")
                    Fluttertoast.showToast(
                        msg: "Thêm thành công !");
                }));
              },
            ),
          ),
          body: PageView.builder(
              controller: _eventPageController,
              itemCount: 2,
              itemBuilder: (context, pagePosition) {
                if (pagePosition == 0)
                  return EventHappening(
                    listTransaction: widget.listTransaction,
                    listEvent: widget.listEvent,
                  );
                else {
                  return EventEnd(
                    listTransaction: widget.listTransaction,
                    listEvent: widget.listEvent,
                  );
                }
              }),
        ),
      ),
    );
  }
}
