import 'package:flutter/material.dart';
import '/views/home/home_page.dart';
import '/views/form/order_form.dart';
import '/views/list/list_page.dart';
import '/views/navigation/settings.dart';
import '/localization/localization.dart';

class NavigationBarApp extends StatefulWidget {
  @override
  State<NavigationBarApp> createState() => NavigationBarAppState();
}

class NavigationBarAppState extends State<NavigationBarApp> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  // App pages to navigate
  final List<Widget> pages = [
    HomePage(),
    OrderForm(),
    OrderList(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ScrollPhysics getScrollPhysics() {
    if (currentPageIndex == 2) { // Disable swipe on the OrderList page
      return NeverScrollableScrollPhysics();
    }
    return AlwaysScrollableScrollPhysics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        },
        selectedIndex: currentPageIndex,
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: l('home', context),
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box),
            label: l('order_form', context),
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: l('order_list', context),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: l('settings', context),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: getScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: pages,
      ),
    );
  }
}