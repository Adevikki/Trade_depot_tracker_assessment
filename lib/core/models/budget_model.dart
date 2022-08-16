import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BudgetClass {
  final ItemSource? item;
  final String? itemName;
  final String? amount;
  final double? progress;
  final String? icon;
  final Widget route;
  final Color? color;

  const BudgetClass({
    this.icon,
    this.item,
    this.itemName,
    this.color,
    this.amount,
    this.progress,
   required this.route,
  });
}

enum ItemSource {
  item1,
  item2,
  item3,
  item4,
  item5,
  none,
}

String budgetSourceToString(ItemSource source) {
  switch (source) {
    case ItemSource.item1:
      return "Item 1";
    case ItemSource.item2:
      return "Item 2";
    case ItemSource.item3:
      return "Item3";
    case ItemSource.item4:
      return "Item4";
    case ItemSource.item5:
      return "Item5";
    default:
      return "Unknown";
  }
}

final budgetSourceProvider = StateProvider.autoDispose<ItemSource>(
  ((ref) => ItemSource.none),
);

class BudgetItem {
  final void Function()? onTap;
  final BudgetClass item;

  const BudgetItem({
    this.onTap,
    required this.item,
  });
}
