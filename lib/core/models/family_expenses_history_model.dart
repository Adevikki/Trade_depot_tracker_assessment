import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyExpensesHistoryClass {
  final ExpensesHistoryItems? item;
  final String? itemName;
  final String? amount;
  final String? icon;
  final Widget? route;
  final String? date;

  const FamilyExpensesHistoryClass({
    this.item,
    this.itemName,
    this.amount,
    this.icon,
    this.route,
    this.date,
  });
}

enum ExpensesHistoryItems {
  item1,
  item2,
  item3,
  item4,
  item5,
  none,
}

String budgetSourceToString(ExpensesHistoryItems source) {
  switch (source) {
    case ExpensesHistoryItems.item1:
      return "Item 1";
    case ExpensesHistoryItems.item2:
      return "Item 2";
    case ExpensesHistoryItems.item3:
      return "Item3";
    case ExpensesHistoryItems.item4:
      return "Item4";
    case ExpensesHistoryItems.item5:
      return "Item5";
    default:
      return "Unknown";
  }
}

final familyexpensesHistoryProvider =
    StateProvider.autoDispose<ExpensesHistoryItems>(
  ((ref) => ExpensesHistoryItems.none),
);
