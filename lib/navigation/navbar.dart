import 'package:flutter/material.dart';
import 'home_page.dart';
import '../form/order_form.dart';
import '../list/order_list.dart';
import 'settings/settings.dart';

class NavigationBarApp extends StatefulWidget {
  @override
  State<NavigationBarApp> createState() => NavigationBarAppState();
}

class NavigationBarAppState extends State<NavigationBarApp> {
  int currentPageIndex = 0;

  //App pages to navigate
  final pages = <Widget>[
    HomePage(),
    OrderForm(),
    OrderList(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box),
            label: 'Order Form',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Order List',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
