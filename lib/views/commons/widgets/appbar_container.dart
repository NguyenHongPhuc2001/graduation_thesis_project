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
      required this.text, required this.screenPageController})
      : super(key: key);

  @override
  State<AppBarContainer> createState() => _AppBarContainerState();
}

class _AppBarContainerState extends State<AppBarContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
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
                alignment: Alignment.center,
                width: size.width * 0.75,
                child: TextHeaderContainer(
                  text: widget.text,
                  textColor: Colors.black,
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
          widget.screenPageController.jumpToPage(indexTab);
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
    );
  }
}
