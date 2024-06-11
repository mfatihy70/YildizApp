// Filename: database_server_tile.dart
import 'package:flutter/material.dart';

Widget databaseServerTile(context, settingsNotifier) {
  final ipController = TextEditingController();
  final dbNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  return ListTile(
    title: Text('Database Server'),
    trailing: Icon(Icons.storage),
    onTap: () {
      ipController.text = settingsNotifier.ipAddress;
      dbNameController.text = settingsNotifier.dbName;
      usernameController.text = settingsNotifier.username;
      passwordController.text = settingsNotifier.password;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Database Connection'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: ipController,
                      decoration: InputDecoration(
                        labelText: 'IP Address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dbNameController,
                      decoration: InputDecoration(
                        labelText: 'Database Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  settingsNotifier.setIpAddress(ipController.text);
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