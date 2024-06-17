import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart';

Widget databaseServerTile(context, settingsNotifier) {
  final hostController = TextEditingController();
  final dbNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  return ListTile(
    title: Text(l('database_connection', context)),
    trailing: Icon(Icons.storage),
    onTap: () {
      hostController.text = settingsNotifier.host;
      dbNameController.text = settingsNotifier.dbName;
      usernameController.text = settingsNotifier.username;
      passwordController.text = settingsNotifier.password;

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
                      controller: hostController,
                      decoration: InputDecoration(
                        labelText: l('host', context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dbNameController,
                      decoration: InputDecoration(
                        labelText: l('database_name', context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: l('username', context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
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
                  settingsNotifier.setIpAddress(hostController.text);
                  settingsNotifier.setDbName(dbNameController.text);
                  settingsNotifier.setUsername(usernameController.text);
                  settingsNotifier.setPassword(passwordController.text);
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