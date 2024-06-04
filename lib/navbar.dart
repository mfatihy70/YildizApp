import 'package:flutter/material.dart';
import "themes/system_theme.dart";
import 'order_form.dart';
import 'order_list.dart';

class NavigationBarApp extends StatefulWidget {
  @override
  State<NavigationBarApp> createState() => NavigationBarAppState();
}

class NavigationBarAppState extends State<NavigationBarApp> {
  int currentPageIndex = 0;

  final pages = <Widget>[
    OrderForm(),
    OrderList(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.add_box),
              label: 'Order Form',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Order List',
            ),
            // Add other destinations here
          ],
        ),
        body: pages[currentPageIndex],
      ),
    );
  }
}
