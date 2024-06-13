import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart';

class AccountSettings extends StatefulWidget {
  @override
  AccountSettingsState createState() => AccountSettingsState();
  String name(context) => l('account', context);
}

class AccountSettingsState extends State<AccountSettings> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('User Account'),
        ),
        ListTile(
          title: Text('Delete Account'),
          onTap: () {
          },
        ),
        ListTile(
          title: Text('Change Password'),
          onTap: () {
          },
        ),
      ],
    );
  }
}
