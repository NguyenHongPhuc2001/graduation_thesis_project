import '../un_used/ExpenseNew.dart';

class ExpenseDAO {
  final List<ExpenseNew> listData = [];

  ExpenseNew ex1 = ExpenseNew(expenseId: 1,
      expenseName: "Ăn uống",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-10-01",
      expenseValue: 25000);
  ExpenseNew ex2 = ExpenseNew(expenseId: 2,
      expenseName: "Xăng",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-10-05",
      expenseValue: 6000);
  ExpenseNew ex3 = ExpenseNew(expenseId: 3,
      expenseName: "Đi chơi",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-10-14",
      expenseValue: 120000);
  ExpenseNew ex4 = ExpenseNew(expenseId: 4,
      expenseName: "Lương",
      expenseType: "Thu",
      expenseIcon: "icon",
      expenseDate: "2022-10-29",
      expenseValue: 200000);
  ExpenseNew ex5 = ExpenseNew(expenseId: 5,
      expenseName: "Mua quà",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-10-16",
      expenseValue: 250000);
  ExpenseNew ex6 = ExpenseNew(expenseId: 6,
      expenseName: "Ăn uống",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-10-31",
      expenseValue: 25000);
  ExpenseNew ex7 = ExpenseNew(expenseId: 7,
      expenseName: "Ăn uống",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-11-01",
      expenseValue: 25000);
  ExpenseNew ex8 = ExpenseNew(expenseId: 8,
      expenseName: "Lương",
      expenseType: "Thu",
      expenseIcon: "icon",
      expenseDate: "2022-11-02",
      expenseValue: 250000);
  ExpenseNew ex9 = ExpenseNew(expenseId: 9,
      expenseName: "Xăng",
      expenseType: "Chi",
      expenseIcon: "icon",
      expenseDate: "2022-11-05",
      expenseValue: 50000);

  List<ExpenseNew> getListData(){
    listData.add(ex1);
    listData.add(ex2);
    listData.add(ex3);
    listData.add(ex4);
    listData.add(ex5);
    listData.add(ex6);
    listData.add(ex7);
    listData.add(ex8);
    listData.add(ex9);
    return listData;
  }
}