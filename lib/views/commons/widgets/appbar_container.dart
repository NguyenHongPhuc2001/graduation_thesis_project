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
      backgroundColor: Colors.white,
      flexibleSpace: Column(
        children: [
          Row(
            children: [
              IconButton(
                iconSize: size.width*0.06,
                onPressed: () {
                  setState(() {
                    widget.pageController.jumpToPage(0);
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: size.width*0.06,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: size.width*0.04),
                alignment: Alignment.center,
                width: size.width * 0.70,
                child: TextHeaderContainer(
                  text: widget.text,
                  textColor: Colors.black
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * 0.1),
              color: Colors.white,
            ),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.1),
              ),
              onTap: widget.onTap,
              child: Container(
                width: size.width * 0.23,
                padding: EdgeInsets.all(size.width*0.015),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(size.width * 0.1),
                ),
                child: Text(
                  "Thêm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottom: TabBar(
        onTap: (indexTab) {
          setState(() {
            widget.screenPageController.jumpToPage(indexTab);
            currentIndex = indexTab;
          });
        },
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
        indicatorWeight: size.width*0.008,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Padding(
            padding: EdgeInsets.all(size.width*0.015),
            child: Text(
                "Đang diễn ra",
                style: TextStyle(
                  fontSize: size.width*0.04,
                  fontWeight: FontWeight.w600
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width*0.015),
            child: Text(
                "Đã kết thúc",
                style: TextStyle(
                  fontSize: size.width*0.04,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );
  }
}
