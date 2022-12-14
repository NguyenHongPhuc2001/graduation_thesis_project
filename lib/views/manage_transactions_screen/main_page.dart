import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/history_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:intl/intl.dart';
import 'history_page.dart';

// ignore: must_be_immutable
class ManageTransaction extends StatefulWidget {
  bool check;

  ManageTransaction({
    Key? key,
    required this.check,
  }) : super(key: key);

  @override
  State<ManageTransaction> createState() => _ManageTransactionState();
}

class _ManageTransactionState extends State<ManageTransaction> {
  final List<Tab> listTabs = [];
  int _selectedIndex = DateTime.now().month - 1;
  final listItems = <String>["Tuần", "Tháng"];
  String currentItem = "Tuần";

  DateFormat df = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    _selectedIndex = DateTime.now().month - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    listTabs.clear();
    for (int i = 1; i <= 12; i++) {
      if (i == DateTime.now().month) {
        String now = "THÁNG NÀY";
        listTabs.add(
          Tab(
            text: now,
          ),
        );
      } else if (i == (DateTime.now().month - 1)) {
        String previous = "THÁNG TRƯỚC";
        listTabs.add(
          Tab(
            text: previous,
          ),
        );
      } else {
        listTabs.add(
          Tab(
            text: "$i/${DateTime.now().year}",
          ),
        );
      }
    }

    return SafeArea(
      child: DefaultTabController(
        length: listTabs.length,
        initialIndex: _selectedIndex,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            // toolbarHeight: size.height * 0.12,
            title: Visibility(
              visible: false,
              child: InkWell(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                splashColor: Colors.white,
                highlightColor: Colors.white,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.8,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(size.width * 0.01),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(width: size.width * 0.07),
                      TextContainer(
                        text: "Tìm kiếm ",
                        textColor: Colors.black,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.02),
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onSelected: (value) async {
                    await HistoryController()
                        .createTransaction(
                            "2022-12-11", 120000.0, "giao dich 7", 1, 1, 1)
                        .then((value) {
                    });

                    setState(() {
                      currentItem = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return listItems.map((String choice) {
                      return PopupMenuItem<String>(
                        onTap: () {},
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            ],
            bottom: TabBar(
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
              isScrollable: true,
              tabs: listTabs,
            ),
          ),
          body: OverviewManageTransaction(
            month: _selectedIndex,
            day: 1,
            check: widget.check,
          ),
        ),
      ),
    );
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  String getNameOfDays(int month) {
    String date = "";
    switch (month) {
      case 1:
        date = "Thứ hai";
        break;
      case 2:
        date = "Thứ ba";
        break;
      case 3:
        date = "Thứ tư";
        break;
      case 4:
        date = "Thứ năm";
        break;
      case 5:
        date = "Thứ sáu";
        break;
      case 6:
        date = "Thứ bảy";
        break;
      case 7:
        date = "Chủ nhật";
        break;
      default:
        date = "Error";
        break;
    }
    return date;
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchItems = [
    "Ăn uống",
    "Nhiên liệu",
    "Đổ xăng",
    "Đi chơi",
    "Sức khỏe",
    "Hóa đơn",
    "Học tập",
    "Lương"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  // TODO: implement textInputAction
  TextInputAction get textInputAction {
    return TextInputAction.search;
  }

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel {
    return "Tìm theo tên giao dịch, theo ngày, ....";
  }

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle {
    return const TextStyle(fontSize: 13);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var transaction in searchItems) {
      if (transaction.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(transaction);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var transaction in searchItems) {
      if (transaction.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(transaction);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
