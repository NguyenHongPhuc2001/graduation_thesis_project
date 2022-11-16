import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_add.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_end.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_happening.dart';

import '../../../../models/event.dart';
import '../../../../models/expense.dart';

class EventScreen extends StatefulWidget {
  final PageController pageController;
  final List<Event> listEvent;
  final Event? event;
  final List<Expense> listTransaction;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    EventController().getListEvent("Phuc").then((value) {
      setState((){
        ls = List.from(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEvent(listEvent: ls, status: true),
                  ),
                ).then((value) {
                  setState(() {
                    if (value == "Create") {
                      ls.clear();
                      // EventAPI()
                      //     .getList("Phuc")
                      //     .then((value) => value.forEach((element) {
                      //       setState(() {
                      //         ls.add(element);
                      //       });
                      // }));
                      EventController().getListEvent("Phuc").then((value) {
                        setState(() {
                          ls = List.from(value);
                        });
                      });

                      Fluttertoast.showToast(msg: "Add event successfully !");
                    }
                  });
                });
              },
            ),
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _eventPageController,
            children: [
              EventHappening(listEvent: ls, listTransaction: []),
              EventEnd(listEvent: ls, listTransaction: []),
            ],
          ),
        ),
      ),
    );
  }
}
