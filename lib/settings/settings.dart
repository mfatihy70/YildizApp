import 'package:flutter/material.dart';
import 'package:yildiz_app/settings/general.dart';
import 'package:yildiz_app/settings/notifications.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('General'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications),
                label: Text('Notifications'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.lock),
                label: Text('Privacy'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_circle),
                label: Text('Account'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.info),
                label: Text('About'),
              ),
            ],
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          VerticalDivider(thickness: 1, width: 1, color: Colors.grey),
          Expanded(
            child: _getSelectedPage(_selectedIndex, context),
          ),
        ],
      ),
    );
  }
}

Widget _getSelectedPage(int selectedIndex, BuildContext context) {
  switch (selectedIndex) {
    case 0:
      return GeneralMenu();
    case 1:
      return NotificationMenu();
    case 2:
      return Center(child: Text('Welcome to Privacy Settings!'));
    case 3:
      return Center(child: Text('Welcome to Account Settings!'));
    case 4:
      return Center(child: Text('Welcome to About Settings!'));
    default:
      return Center(child: Text('Welcome to General Settings!'));
  }
}
