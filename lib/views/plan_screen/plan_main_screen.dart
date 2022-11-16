import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/models/event.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/models/goal.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';

import 'package:graduation_thesis_project/views/commons/widgets/single_row_container_2.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_screen.dart';

class PlanMainScreen extends StatefulWidget {
  final List<Expense> listTransaction;

  const PlanMainScreen({
    Key? key,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<PlanMainScreen> createState() => _PlanMainScreenState();
}

class _PlanMainScreenState extends State<PlanMainScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List<Goal> listTarget = [];
  List<Event> listEvent = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventController()
        .getListEvent("Phuc")
        .then((value) {
          setState(() {
            listEvent = List.from(value);
          });
    });

    GoalController()
        .getListGoal("Phuc")
        .then((value) {
          setState(() {
            listTarget = List.from(value);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, position) {
            if (position == 0) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.width * 0.15,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.grey,
                          blurRadius: size.width * 0.03,
                        ),
                      ],
                      color: Colors.lightBlue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size.width * 0.35),
                        bottomRight: Radius.circular(size.width * 0.35),
                      ),
                    ),
                    child: Text(
                      "Lập kế hoạch",
                      style: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _singleRowItem(
                          onPress: () {
                            setState(() {
                              _pageController.jumpToPage(1);
                            });
                          },
                          title: "Ngân sách",
                          sentence:
                              "Một ngân sách chi tiết sẽ giúp bạn kiểm soát chi tiêu của bản thân tốt hơn.",
                          leadingIcon: Icons.list,
                        ),
                        _singleRowItem(
                          onPress: () {
                            setState(() {
                              _pageController.jumpToPage(2);
                            });
                          },
                          title: "Sự kiện",
                          sentence:
                              "Hãy tạo một sự kiện để quản lý các giao dịch trong một sự kiện đời thực "
                              "nào đó. VD: du lịch, sinh nhật, ...",
                          leadingIcon: Icons.event,
                        ),
                        _singleRowItem(
                          onPress: () {
                            setState(() {
                              _pageController.jumpToPage(3);
                            });
                          },
                          title: "Mục tiêu",
                          sentence:
                              "Một mục tiêu tốt sẽ trở thành động lực để bạn phấn đấu !!!",
                          leadingIcon: Icons.noise_aware_sharp,
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (position == 1) {
              return BudgetScreen(
                  pageController: _pageController,
                  // listBudget: null,
                  // listTransaction: widget.listTransaction,
                  );
            } else if (position == 2) {
              return EventScreen(
                pageController: _pageController,
                listEvent: listEvent,
                listTransaction: widget.listTransaction,
              );
            } else {
              return TargetScreen(
                pageController: _pageController,
                listTarget: listTarget,
              );
            }
          },
        ),
      ),
    );
  }
}

class _singleRowItem extends StatelessWidget {
  final String title, sentence;
  final IconData leadingIcon;
  final VoidCallback onPress;

  const _singleRowItem({
    Key? key,
    required this.title,
    required this.sentence,
    required this.leadingIcon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPress,
      child: Container(
        width: size.width * 0.95,
        height: size.width * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.03),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: size.width * 0.04,
              color: Colors.grey.shade400,
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              leadingIcon,
              size: size.width * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.01),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.63,
                  child: Text(
                    sentence,
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_right,
              size: size.width * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
