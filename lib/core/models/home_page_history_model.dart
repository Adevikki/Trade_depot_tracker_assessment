import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageHistoryClass {
  final HomeItemSource? item;
  final String? itemName;
  final String? amount;
  final String? icon;

  const HomePageHistoryClass({
    this.item,
    this.itemName,
    this.amount,
    this.icon,
  });

  const HomePageHistoryClass._({
    this.item = HomeItemSource.none,
    this.amount = '',
    this.itemName = '',
    this.icon,
  });

  const factory HomePageHistoryClass.empty() = HomePageHistoryClass._;
}

enum HomeItemSource {
  item1,
  item2,
  item3,
  item4,
  item5,
  none,
}

String budgetSourceToString(HomeItemSource source) {
  switch (source) {
    case HomeItemSource.item1:
      return "Item 1";
    case HomeItemSource.item2:
      return "Item 2";
    case HomeItemSource.item3:
      return "Item3";
    case HomeItemSource.item4:
      return "Item4";
    case HomeItemSource.item5:
      return "Item5";
    default:
      return "Unknown";
  }
}

final expensesHistoryProvider = StateProvider.autoDispose<HomeItemSource>(
  ((ref) => HomeItemSource.none),
);
