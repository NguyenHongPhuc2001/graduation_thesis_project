import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:graduation_thesis_project/views/commons/widgets/appbar_container.dart';

import '../../../../models/budget.dart';
import '../../../../remote/controllers/entites/budget_controller.dart';
import 'budget_create.dart';
import 'budget_end.dart';
import 'budget_happening.dart';

class BudgetScreen extends StatefulWidget {

  final PageController pageController;
  final budgetController = Get.put(BudgetController());

  BudgetScreen( {Key? key, required this.pageController}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();

}

class _BudgetScreenState extends State<BudgetScreen> {

  final PageController _budgetPageController = PageController();

  bool check = false;


  @override
  Widget build(BuildContext context) {

    _loadBudgetList();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(size.width, size.width * 0.33),
            child: AppBarContainer(
              text: "Ngân sách",
              screenPageController: _budgetPageController,
              pageController: widget.pageController,
              onTap: () async {
                await Get.to(BudgetCreate())!.then((value) {
                  if(value =="Create"){
                    setState(() {
                      widget.budgetController.getBudgets();
                      check = true;
                    });
                  }
                });
              },
            ),
          ),
          body: PageView.builder(
              controller: _budgetPageController,
              itemCount: 2,
              itemBuilder: (context, pagePosition) {
                if (pagePosition == 0) {

                  return BudgetHappening(
                    listBudget: widget.budgetController.budgetList.where((b) => b.budgetExpired == false).toList(),
                    check: check,
                  );
                } else {
                  return BudgetEnd(
                    listBudget: widget.budgetController.budgetList.where((b) => b.budgetExpired == true).toList(),
                  );
                }
              }),
        ),
      ),
    );

  }

  _loadBudgetList(){
    widget.budgetController.getBudgets();
  }

}
