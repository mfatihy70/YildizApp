import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  @override
  AccountSettingsState createState() => AccountSettingsState();
  String name() => 'Account';
}

class AccountSettingsState extends State<AccountSettings> {
  bool _receiveNotifications = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: Text('Receive Notifications'),
          value: _receiveNotifications,
          onChanged: (value) {
            setState(() {
              _receiveNotifications = value;
            });
          },
        ),
        SwitchListTile(
          title: Text('Dark Mode'),
          value: _darkModeEnabled,
          onChanged: (value) {
            setState(() {
              _darkModeEnabled = value;
            });
          },
        ),
        // Add more settings widgets here
      ],
    );
  }
}
