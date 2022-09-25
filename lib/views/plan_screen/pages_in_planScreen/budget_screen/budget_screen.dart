import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_end.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_happening.dart';

class BudgetScreen extends StatefulWidget {
  final PageController pageController;

  const BudgetScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: size.width * 0.23,
            flexibleSpace: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.pageController.jumpToPage(0);
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: size.width * 0.75,
                      child: Text(
                        "Ngân sách",
                        style: TextStyle(
                          fontSize: size.width * 0.075,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.1),
                      color: Colors.blue,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size.width * 0.1),
                        ),
                        onTap: () {},
                        child: Container(
                          width: size.width * 0.3,
                          padding: EdgeInsets.only(
                              top: size.width * 0.02,
                              bottom: size.width * 0.02,
                              right: size.width * 0.05,
                              left: size.width * 0.05),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.1),
                          ),
                          child: Text(
                            "Thêm",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              onTap: (indexTab) {
                _pageController.jumpToPage(indexTab);
              },
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              tabs: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Đang diễn ra"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Đã kết thúc"),
                ),
              ],
            ),
          ),
          body: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              itemBuilder: (context, pagePosition) {
                if (pagePosition == 0)
                  return BudgetHappening();
                else
                  return BudgetEnd();
              }),
        ),
      ),
    );
  }
}
