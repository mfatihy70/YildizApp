import 'package:flutter/material.dart';
import 'package:yildiz_app/settings/destinations/about.dart';
import 'package:yildiz_app/settings/destinations/account.dart';
import 'package:yildiz_app/settings/destinations/general.dart';
import 'package:yildiz_app/settings/destinations/notifications.dart';
import 'package:yildiz_app/localization.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;
  List<NavigationRailDestination> _destinations = [];

  final List<Widget> _pages = [
    GeneralSettings(),
    NotificationSettings(),
    AccountSettings(),
    AboutPage(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeDestinations();
  }

  void _initializeDestinations() {
    _destinations = [
      NavigationRailDestination(
        icon: Icon(Icons.settings),
        label: Text(l('general', context)),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.notifications),
        label: Text(l('notificationss', context)),
      ),
      NavigationRailDestination(
          icon: Icon(Icons.account_circle), label: Text(l('account', context))),
      NavigationRailDestination(
        icon: Icon(Icons.info),
        label: Text(l('about', context)),
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text((_pages[_selectedIndex] as dynamic).name(context)),
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
          VerticalDivider(
              thickness: 1,
              width: 1,
              color: const Color.fromARGB(164, 158, 158, 158)),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
