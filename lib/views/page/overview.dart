import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/wallet_controller.dart';
import 'package:graduation_thesis_project/utils/charts/bar.dart';
import 'package:graduation_thesis_project/utils/date/date_utils.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

import '../../models/history.dart';
import '../../remote/controllers/entites/history_controller.dart';
import '../transaction_screen/wallet_screen/wallet_list.dart';

// ignore: must_be_immutable
class Overview extends StatefulWidget {

  WalletController walletController = Get.put(WalletController());

  Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  List<charts.Series<Withdraw, String>> dataWeek = [];
  List<charts.Series<Withdraw, String>> dataMonth = [];

  List<String> items = [
    "Tuần",
    "Tháng"
  ];

  var choose = 'month';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createDataWeek().then((value){
      dataWeek = value;
    });

    _createDataMonth().then((value){
      dataMonth = value;
    });

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xE9ECEFED),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Ví của tôi",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),),
                              SizedBox(
                                width: size.width * 0.07,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    Get.to(WalletList(isTransaction:false));
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      const CircleBorder(),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(EdgeInsets.zero)
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width : 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.deepOrangeAccent,
                                ),
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: SvgPicture.asset("images/sample_wallet.svg"),
                                ),
                              ),
                              const Text(
                                "Tên ví",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                width: size.width * 0.4,
                                height: size.width * 0.08,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("2.050.000"),
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                        child: const Text(
                                          "VNĐ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                  style: BorderStyle.solid
                                ),

                              )
                            ),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Số dư tất cả các ví",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),
                              SizedBox(
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(100),
                                          )
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        child: const Text(
                                          "2,050,000 VNĐ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Mục tiêu tháng",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),
                              SizedBox(
                                width: size.width * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width : 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.amber,
                                ),
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: SvgPicture.asset("images/simple_crown.svg"),
                                ),
                              ),
                              const Text(
                                "Tên mục tiêu",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  width: size.width * 0.4,
                                  height: size.width * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("2.050.000"),
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: const Text(
                                            "VNĐ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black,
                                        width: 0.3,
                                        style: BorderStyle.solid
                                    ),

                                  )
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Tiến độ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Báo cáo",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),
                              SizedBox(
                                width: size.width * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Container(
                              width: size.width * 0.6,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: AnimatedContainer(
                                      alignment: Alignment.center,
                                      width: size.width * 0.28,
                                      decoration: BoxDecoration(
                                          color: choose == 'week' ? Colors.blue : Colors.white,
                                          borderRadius: BorderRadius.circular(50),
                                          boxShadow: const [
                                             BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1,
                                              spreadRadius: 1
                                            )
                                          ]
                                      ),
                                      duration: const Duration(seconds: 300),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            choose = 'week';
                                          });
                                        },
                                        child: Text(
                                          "Tuần",
                                          style: choose == 'week' ?
                                          const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ) : const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: AnimatedContainer(
                                      alignment: Alignment.center,
                                      width: size.width * 0.28,
                                      decoration: BoxDecoration(
                                          color: choose == 'month' ? Colors.blue : Colors.white,
                                          borderRadius: BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 1,
                                                spreadRadius: 1
                                            )
                                          ]
                                      ),
                                      duration: const Duration(seconds: 300),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            choose = 'month';
                                          });
                                        },
                                        child: Text(
                                          "Tháng",
                                          style: choose == 'month' ?
                                          const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ) : const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Text(
                                  "Tổng chi tháng này",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: const [
                                    Text(
                                        "2.050.000"
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.5,
                            width: size.width * 0.9,
                            child: CustomRoundedBars(seriesList: choose == 'week' ? dataWeek : dataMonth, animate: false,)
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                  "Chi nhiều nhất",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12
                                  ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width : 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.amber,
                                ),
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: SvgPicture.asset("images/MoneyIcon_1.svg"),
                                ),
                              ),
                              const Text(
                                "0.95" " %",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red
                                  ),
                                ),
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  width: size.width * 0.4,
                                  height: size.width * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("2.050.000"),
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: const Text(
                                            "VNĐ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Giao dịch gần đây",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),
                              SizedBox(
                                width: size.width * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width : 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.amber,
                                ),
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: SvgPicture.asset("images/BoxIcon.svg"),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Tên chi tiêu",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "13/09/2022",
                                    style: TextStyle(
                                      fontSize: 10
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  width: size.width * 0.4,
                                  height: size.width * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("2.050.000"),
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: const Text(
                                            "VNĐ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
            ),
        ),
      ),
    );
  }

  Future<double> _totalWithdraw(List<String> dates) async {

    Future<List<History>?> histories = HistoryController().getHistoriesByWithdraw();

    double totalWithdraw = 0.0;

    await histories.then((value) {
      for (var h in value!) {
        for (var d in dates) {
          if(h.historyNotedDate!.trim() == d.trim()){
            totalWithdraw += h.historyCost!;
            break;
          }
        }
      }
    });

    return totalWithdraw;
  }

  Future<List<charts.Series<Withdraw, String>>> _createDataWeek() async {

    List<String> dateOfCurrentWeek = DateUtilsCustom().getDateOfWeek(DateTime.now());
    List<String> dateOfLastWeek = DateUtilsCustom().getDateOfWeek(DateTime.now().subtract(const Duration(days: 7)));

    double totalLastWithdraw = 0.0;
    double totalCurrentWithdraw = 0.0;

    await _totalWithdraw(dateOfCurrentWeek).then((value){
      totalCurrentWithdraw = value;
    });

    await _totalWithdraw(dateOfLastWeek).then((value){
      totalLastWithdraw = value;
    });

    final data = [
      Withdraw("Tuần trước", totalLastWithdraw),
      Withdraw("Tuần này", totalCurrentWithdraw),
    ];

    return [
      charts.Series<Withdraw, String>(
        id: 'Withdraw',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Withdraw withdraw, _) => withdraw.title,
        measureFn: (Withdraw withdraw, _) => withdraw.total,
        data: data,
      )
    ];
  }

  Future<List<charts.Series<Withdraw, String>>> _createDataMonth() async {

    List<String> datesOfCurrentMonth = [];
    List<String> datesOfLastMonth = [];

    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;

    bool check = false;

    int totalDatesOfCurrentMonth = DateUtils.getDaysInMonth(currentYear, currentMonth);
    int totalDatesOfLastMonth = 0;

    if(currentMonth - 1 == 0){
      check = true;
      totalDatesOfLastMonth = DateUtils.getDaysInMonth(currentYear - 1, 12);
    }else{
      totalDatesOfLastMonth = DateUtils.getDaysInMonth(currentYear, currentMonth - 1);
    }

    for (var i = 0; i < totalDatesOfCurrentMonth; i++) {
      datesOfLastMonth.add( '$currentYear-$currentMonth-${i + 1}');
    }

    if (check) {
      for (var i = 0; i < totalDatesOfLastMonth; i++) {
        datesOfLastMonth.add( '${currentYear-1}-12-${i + 1}');
      }
    }else{
      for (var i = 0; i < totalDatesOfLastMonth; i++) {
        datesOfLastMonth.add( '$currentYear-${currentMonth - 1}-${i + 1}');
      }
    }

    double totalLastWithdraw = 0.0;
    double totalCurrentWithdraw = 0.0;

    await _totalWithdraw(datesOfCurrentMonth).then((value){
      totalCurrentWithdraw = value;
    });

    await _totalWithdraw(datesOfLastMonth).then((value){
      totalLastWithdraw = value;
    });

    final data = [
      Withdraw("Tháng trước", totalLastWithdraw),
      Withdraw("Tháng này", totalCurrentWithdraw),
    ];

    return [
      charts.Series<Withdraw, String>(
        id: 'Withdraw',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Withdraw withdraw, _) => withdraw.title,
        measureFn: (Withdraw withdraw, _) => withdraw.total,
        data: data,
      )
    ];
  }

}

class Withdraw {
  final String title;
  final double total;

  Withdraw(this.title, this.total);

}
