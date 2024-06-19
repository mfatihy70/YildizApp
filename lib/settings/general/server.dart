import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart';

Widget databaseServerTile(context, settingsNotifier) {
  final hostC = TextEditingController();
  final dbNameC = TextEditingController();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  return ListTile(
    title: Text(l('database_connection', context)),
    trailing: Icon(Icons.storage),
    onTap: () {
      hostC.text = settingsNotifier.host;
      dbNameC.text = settingsNotifier.dbName;
      usernameC.text = settingsNotifier.username;
      passwordC.text = settingsNotifier.password;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(l('edit_database_connection', context)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: hostC,
                      decoration: InputDecoration(
                        labelText: l('host', context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dbNameC,
                      decoration: InputDecoration(
                        labelText: l('database_name', context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameC,
                      decoration: InputDecoration(
                        labelText: l('username', context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordC,
                      decoration: InputDecoration(
                        labelText: l('password', context),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(l('cancel', context)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(l('save', context)),
                onPressed: () {
                  settingsNotifier.setIpAddress(hostC.text);
                  settingsNotifier.setDbName(dbNameC.text);
                  settingsNotifier.setUsername(usernameC.text);
                  settingsNotifier.setPassword(passwordC.text);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    },
  );
}