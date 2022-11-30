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

  const TargetScreen({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  final PageController _targetPageController = PageController();
  List<Goal> listGoalHappenning = [];
  List<Goal> listGoalEnd = [];
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    GoalController().getByStatus(false).then((value) {
      setState(() {
        listGoalHappenning = List.from(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(size.width, size.width * 0.33),
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
                        GoalController().getByStatus(false).then((value) {
                          setState(() {
                            listGoalHappenning = List.from(value);
                            check = true;
                          });
                        });
                        Fluttertoast.showToast(
                            msg: "Thêm mục tiêu thành công !");
                      }
                    }));
              },
            ),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _targetPageController,
            children: [
              TargetHappening(listGoal: listGoalHappenning, check: check),
              TargetEnd(),
            ],
          ),
        ),
      ),
    );
  }
}
