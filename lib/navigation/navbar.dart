import 'package:flutter/material.dart';
import 'home_page.dart';
import '../form/order_form.dart';
import '../list/order_list.dart';
import '../settings/settings.dart';
import 'package:yildiz_app/localization.dart';

class NavigationBarApp extends StatefulWidget {
  @override
  State<NavigationBarApp> createState() => NavigationBarAppState();
}

class NavigationBarAppState extends State<NavigationBarApp> {
  l(key) => AppLocalizations.of(context).translate(key);
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
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: l('home'),
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box),
            label: l('order_form'),
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: l('order_list'),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: l('settings'),
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
