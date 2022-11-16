class ExpenseNew {
  int expenseId;
  String expenseName;
  String expenseType;
  String expenseIcon;
  String expenseDate;
  double expenseValue;
  List<dynamic>? histories;

  ExpenseNew({
    required this.expenseId,
    required this.expenseName,
    required this.expenseType,
    required this.expenseIcon,
    required this.expenseDate,
    required this.expenseValue,
    this.histories,
  });

  ExpenseNew.fromJson(Map<String, dynamic> data)
      : this.expenseId = data['expenseId'],
        this.expenseName = data['expenseName'],
        this.expenseIcon = data['expenseIcon'],
        this.expenseType = data['expenseType'],
        this.expenseDate = data['expenseDate'],
  this.expenseValue = data['expenseValue'],
        this.histories = data['histories'];

  Map<String, dynamic> toJson() {
    return {
      'expenseId': this.expenseId,
      'expenseName': this.expenseName,
      'expenseIcon': this.expenseIcon,
      'expenseType': this.expenseType,
      'expenseDate': this.expenseDate,
      'expenseValue':this.expenseValue,
      'histories': this.histories,
    };
  }
}
