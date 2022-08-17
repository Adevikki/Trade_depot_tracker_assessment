import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/menu_screens/budgets_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/menu_screens/categories_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/menu_screens/home_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/utils.dart';

class CustomBottomNavigation extends ConsumerStatefulWidget {
  static const pageId = 'bottom-navigation';

  final int tabIndex;

  const CustomBottomNavigation({
    Key? key,
    this.tabIndex = 0,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends ConsumerState<CustomBottomNavigation> {
  int? _selectedIndex = 0;
  late Timer _timer;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoriesScreen(),
    BudgetsScreen(),
  ];

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.tabIndex;

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex!),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            // border: const Border(
            //   top: BorderSide(width: 0, color: Styles.trackerGrey500),
            // ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 2, // soften the shadow
                spreadRadius: 0.5, //extend the shadow
                offset: const Offset(
                  2, // Move to right 10  horizontally
                  2,
                  // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          height: isIos() ? 70 : 50,
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 4,
              bottom: isIos() ? 20 : 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomBarMenu(
                  context: context,
                  image: _selectedIndex == 0
                      ? '$kImagePath/home_selected.svg'
                      : '$kImagePath/home.svg',
                  selectIndex: 0,
                  text: 'Home',
                ),
                bottomBarMenu(
                  context: context,
                  image: _selectedIndex == 1
                      ? '$kImagePath/categories.svg'
                      : '$kImagePath/categories.svg',
                  selectIndex: 1,
                  text: 'Categories',
                ),
                bottomBarMenu(
                  context: context,
                  image: _selectedIndex == 2
                      ? '$kImagePath/budgets_selected.svg'
                      : '$kImagePath/budgets.svg',
                  selectIndex: 2,
                  text: 'Budget',
                ),
              ],
            ),
          ),
        ));
  }

  Material bottomBarMenu({
    BuildContext? context,
    String? image,
    int? selectIndex,
    String? text,
  }) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          _onItemTapped(selectIndex);
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SvgPicture.asset(
                '$image',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                '$text',
                style: Styles.smallNav(
                  color: selectIndex == _selectedIndex
                      ? Styles.trackerPurple600
                      : Styles.trackerGrey500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
