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
      flexibleSpace: Column(
        children: [
          Row(
            children: [
              IconButton(
                iconSize: 18,
                onPressed: () {
                  setState(() {
                    widget.pageController.jumpToPage(0);
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              Container(
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
                width: size.width * 0.2,
                padding: const EdgeInsets.all(3.0),
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
      backgroundColor: Colors.white,
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
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text(
                "Đang diễn ra",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text(
                "Đã kết thúc",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}
