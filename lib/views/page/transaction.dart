import 'package:flutter/material.dart';

import '../../models/Transaction.dart';
import '../manage_transactions/manage_transaction_main_screen.dart';

class Transaction extends StatefulWidget {
  final List<Transactions> listTransaction;

  const Transaction({
    Key? key,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return ManageTransaction(
      listTransaction: widget.listTransaction,
    );
  }
}
