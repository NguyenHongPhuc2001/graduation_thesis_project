import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/target_dao.dart';
import 'package:graduation_thesis_project/models/target.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_add.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_end.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_happening.dart';

class TargetScreen extends StatefulWidget {
  final PageController pageController;
  final List<Target> listTarget;

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
                    builder: (context) => AddTarget(
                      listTarget: widget.listTarget,
                    ),
                  ),
                ).then((value) => setState(() {
                      if (value == "Save")
                        Fluttertoast.showToast(
                            msg: "Thêm mục tiêu thành công !");
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
                    listTarget: widget.listTarget,
                  );
                else
                  return TargetEnd(
                    listTarget: widget.listTarget,
                  );
              }),
        ),
      ),
    );
  }
}
