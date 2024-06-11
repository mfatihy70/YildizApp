import 'package:flutter/material.dart';
import 'package:yildiz_app/settings/destinations/about.dart';
import 'package:yildiz_app/settings/destinations/account.dart';
import 'package:yildiz_app/settings/destinations/general.dart';
import 'package:yildiz_app/settings/destinations/notifications.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;

  final List<NavigationRailDestination> _destinations = [
    NavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text('General'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.notifications),
      label: Text('Notifications'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.account_circle),
      label: Text('Account'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.info),
      label: Text('About'),
    ),
  ];

  final List<Widget> _pages = [
    GeneralSettings(),
    NotificationSettings(),
    AccountSettings(),
    AboutPage(),
  ];

  String getPageName() {
    try {
      return '${(_pages[_selectedIndex] as dynamic).name()} Settings';
    } catch (_) {
      return _pages[_selectedIndex].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(getPageName()),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.selected,
            destinations: _destinations,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          VerticalDivider(thickness: 1, width: 1, color: const Color.fromARGB(164, 158, 158, 158)),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
