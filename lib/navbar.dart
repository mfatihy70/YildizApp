import 'package:flutter/material.dart';
import 'package:flutter_project/sys_theme.dart';
import 'order_form.dart';
import 'order_list.dart';
import 'db_service.dart';


class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  final pages = <Widget>[
    OrderForm(),
    OrderList(dbService: DatabaseService(),),
    // Add other pages here
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
    );
  }
}