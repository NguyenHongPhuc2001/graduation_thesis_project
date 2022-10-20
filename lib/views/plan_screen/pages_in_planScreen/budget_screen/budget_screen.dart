// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:graduation_thesis_project/models/budget.dart';
// import 'package:graduation_thesis_project/models/Transaction.dart';
// import 'package:graduation_thesis_project/views/commons/widgets/appbar_container.dart';
// import 'package:graduation_thesis_project/ui/budget_add.dart';
// import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_end.dart';
// import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_happening.dart';
//
// class BudgetScreen extends StatefulWidget {
//   final PageController pageController;
//   final List<Budget>? listBudget;
//   final List<Transactions> listTransaction;
//
//   const BudgetScreen(
//       {Key? key,
//       required this.pageController,
//         this.listBudget,
//       required this.listTransaction})
//       : super(key: key);
//
//   @override
//   State<BudgetScreen> createState() => _BudgetScreenState();
// }
//
// class _BudgetScreenState extends State<BudgetScreen> {
//   final PageController _budgetPageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size(size.width, size.width * 0.35),
//             child: AppBarContainer(
//               text: "Ngân sách",
//               screenPageController: _budgetPageController,
//               pageController: widget.pageController,
//               onTap: () async{
//                    await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddBudget(
//                           listBudget: widget.listBudget,
//                         ),
//                       ),
//                     ).then((value) => setState((){
//                       if(value == "Save")
//                         Fluttertoast.showToast(msg: "Thêm ngân sách thành công !");
//                    }));
//                   },
//             ),
//           ),
//           body: PageView.builder(
//               controller: _budgetPageController,
//               itemCount: 2,
//               itemBuilder: (context, pagePosition) {
//                 if (pagePosition == 0)
//                   return BudgetHappening(
//                     listBudget: widget.listBudget,
//                     listTransaction: widget.listTransaction,
//                   );
//                 else
//                   return BudgetEnd(
//                     listTransaction: widget.listTransaction,
//                     listBudget: widget.listBudget,
//                   );
//               }),
//         ),
//       ),
//     );
//   }
// }
