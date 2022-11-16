import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_add.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_end.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_happening.dart';

import '../../../../models/goal.dart';

class TargetScreen extends StatefulWidget {
  final PageController pageController;
  final List<Goal> listTarget;

  const TargetScreen({
    Key? key,
    required this.pageController,
    required this.listTarget,
  }) : super(key: key);

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  final PageController _targetPageController = PageController();
  List<Goal> listGoal = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoalController().getListGoal("Phuc").then((value) {
      setState(() {
        listGoal = List.from(value);
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
              text: "Mục tiêu",
              screenPageController: _targetPageController,
              pageController: widget.pageController,
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTarget(),
                  ),
                ).then((value) => setState(() {
                      if (value == "Create") {
                        listGoal.clear();
                          GoalController().getListGoal("Phuc").then((value) {
                            value.forEach((element) {
                              setState(() {
                                listGoal.add(element);
                              });
                            });
                          });
                        Fluttertoast.showToast(
                            msg: "Thêm mục tiêu thành công !");
                      }
                    }));
              },
            ),
          ),
          body: PageView.builder(
              controller: _targetPageController,
              itemCount: 2,
              itemBuilder: (context, pagePosition) {
                if (pagePosition == 0)
                  return TargetHappening(
                    listTarget: listGoal,
                  );
                else
                  return TargetEnd(
                    listTarget: listGoal,
                  );
              }),
        ),
      ),
    );
  }
}
