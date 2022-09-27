import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/dao/rap_dao.dart';
import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Budget.dart';

class BudgetDAO {
  Budget bg1 = Budget(
    id: 1,
    createDate: DateTime.now(),
    wallet: WalletDAO().wl1,
    rap: RAPDAO().r1,
    budgetValue: 500000,
    endDate: DateTime.now(),
    status: false,
  );

  Budget bg2 = Budget(
    id: 2,
    createDate: DateTime.now(),
    wallet: WalletDAO().wl2,
    rap: RAPDAO().r2,
    budgetValue: 1500000,
    endDate: DateTime.now(),
    status: false,
  );

  Budget bg3 = Budget(
    id: 3,
    createDate: DateTime.now(),
    wallet: WalletDAO().wl3,
    rap: RAPDAO().r3,
    budgetValue: 850000,
    endDate: DateTime.now(),
    status: true,
  );


  List<Budget> listBudget = [];

  List<Budget> getAll(){
    listBudget.add(bg1);
    listBudget.add(bg2);
    listBudget.add(bg3);
    return listBudget;
  }

}
