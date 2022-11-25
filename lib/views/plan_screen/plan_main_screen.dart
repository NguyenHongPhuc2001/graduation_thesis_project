import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/event.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/models/goal.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';

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

    EventController().getListEvent()
        .then((value) {
          setState(() {
            listEvent = List.from(value);
        });
    });

    GoalController()
        .getListGoal()
        .then((value) {
          setState(() {
            listTarget = List.from(value);
          });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, position) {
            if (position == 0) {
              return Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _singleRowItem(
                          onPress: () {
                            setState(() {
                              _pageController.jumpToPage(1);
                            });
                          },
                          title: "Ngân sách",
                          sentence:
                              "Một ngân sách chi tiết sẽ giúp bạn kiểm soát chi tiêu của bản thân tốt hơn.",
                          leadingIcon: "images/plan_budget_icon.svg",
                          backgroundIcon: const Color(0xFF7986CB),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _singleRowItem(
                          onPress: () {
                            setState(() {
                              _pageController.jumpToPage(2);
                            });
                          },
                          title: "Sự kiện",
                          sentence:
                              "Hãy tạo một sự kiện để quản lý các giao dịch trong một sự kiện đời thực "
                              "nào đó. VD: du lịch, sinh nhật, ...",
                          leadingIcon: "images/plan_calendar_icon.svg",
                          backgroundIcon: const Color(0xFF66BB6A),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _singleRowItem(
                          onPress: () {
                            setState(() {
                              _pageController.jumpToPage(3);
                            });
                          },
                          title: "Mục tiêu",
                          sentence:
                              "Một mục tiêu tốt sẽ trở thành động lực để bạn phấn đấu !!!",
                          leadingIcon: "images/plan_goal_icon.svg",
                          backgroundIcon: const Color(0xFF8D6E63),
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else if (position == 1) {
              return BudgetScreen(
                  pageController: _pageController,
                  );
            } else if (position == 2) {
              return EventScreen(
                pageController: _pageController,
                listEvent: listEvent,
                listTransaction: widget.listTransaction,
              );
            } else {
              return TargetScreen(
                pageController: _pageController
              );
            }
          },
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _singleRowItem extends StatelessWidget {

  final String title, sentence;
  final String leadingIcon;
  final Color backgroundIcon;
  final VoidCallback onPress;

  const _singleRowItem({
    Key? key,
    required this.title,
    required this.sentence,
    required this.leadingIcon,
    required this.backgroundIcon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return InkWell(

      onTap: onPress,
      child: Container(
        width: size.width * 0.95,
        height: size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.grey.shade400,
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: backgroundIcon,
                  borderRadius: BorderRadius.circular(100.0)
                ),
                child: SvgPicture.asset(leadingIcon),
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
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: size.width * 0.63,
                      child: Text(
                        sentence,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 25,
                width: 25,
                child: ElevatedButton(
                  onPressed: onPress,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
