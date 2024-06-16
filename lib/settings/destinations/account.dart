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
          trailing: Icon(Icons.account_circle),
          onTap: () {
          },
        ),
        ListTile(
          title: Text('Delete Account'),
          trailing: Icon(Icons.delete),
          onTap: () {
          },
        ),
        ListTile(
          title: Text('Change Password'),
          trailing: Icon(Icons.lock),
          onTap: () {
          },
        ),
      ],
    );
  }
}
