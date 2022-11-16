import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_header_container.dart';

class AppBarContainer extends StatefulWidget {
  final PageController pageController;
  final PageController screenPageController;
  final VoidCallback onTap;
  final String text;

  const AppBarContainer(
      {Key? key,
      required this.pageController,
      required this.onTap,
      required this.text,
      required this.screenPageController})
      : super(key: key);

  @override
  State<AppBarContainer> createState() => _AppBarContainerState();
}

class _AppBarContainerState extends State<AppBarContainer> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(size.width * 0.085),
          bottomRight: Radius.circular(size.width * 0.085),
        ),
      ),
      toolbarHeight: size.width * 0.25,
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
                  color: Colors.white,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.75,
                child: TextHeaderContainer(
                  text: widget.text,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.02),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: size.width * 0.04,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.1),
                  ),
                  onTap: widget.onTap,
                  child: Container(
                    width: size.width * 0.3,
                    padding: EdgeInsets.only(
                        top: size.width * 0.02,
                        bottom: size.width * 0.02,
                        right: size.width * 0.05,
                        left: size.width * 0.05),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.1),
                    ),
                    child: Text(
                      "Thêm",
                      style: TextStyle(
                        color: (currentIndex == 0)
                            ? Color(0xffFB8500)
                            : Color(0xff90E0EF),
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
      backgroundColor:
          (currentIndex == 0) ? Color(0xffFB8500) : Color(0xff90E0EF),
      bottom: TabBar(
        onTap: (indexTab) {
          setState(() {
            widget.screenPageController.jumpToPage(indexTab);
            currentIndex = indexTab;
          });
        },
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xffEDF6F9).withAlpha(150),
        labelStyle: TextStyle(
          fontSize: size.width * 0.045,
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
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
    );
  }
}
