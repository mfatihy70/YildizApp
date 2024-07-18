import 'package:flutter/material.dart';
import '/localization/localization.dart';
import '/controllers/settings/notifiers.dart';

class DatabaseServerTile extends StatefulWidget {
  final SettingsNotifier settingsNotifier;

  DatabaseServerTile({required this.settingsNotifier});

  @override
  DatabaseServerTileState createState() => DatabaseServerTileState();
}

class DatabaseServerTileState extends State<DatabaseServerTile> {
  final hostC = TextEditingController();
  final portC = TextEditingController();
  final dbNameC = TextEditingController();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  bool sslMode = false;

  @override
  void initState() {
    super.initState();
    sslMode = widget.settingsNotifier.sslMode;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(l('database_connection', context)),
      trailing: Icon(Icons.storage),
      onTap: () {
        hostC.text = widget.settingsNotifier.host;
        portC.text = widget.settingsNotifier.port.toString();
        dbNameC.text = widget.settingsNotifier.dbName;
        usernameC.text = widget.settingsNotifier.username;
        passwordC.text = widget.settingsNotifier.password;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
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
                            controller: portC,
                            decoration: InputDecoration(
                              labelText: l('port', context),
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
                        SwitchListTile(
                          title: Text(l('sslmode', context)),
                          value: sslMode,
                          onChanged: (bool value) {
                            setState(() {
                              sslMode = value;
                            });
                          },
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
                        widget.settingsNotifier.setHost(hostC.text);
                        widget.settingsNotifier.setPort(int.parse(portC.text));
                        widget.settingsNotifier.setDbName(dbNameC.text);
                        widget.settingsNotifier.setUsername(usernameC.text);
                        widget.settingsNotifier.setPassword(passwordC.text);
                        widget.settingsNotifier.setSslMode(sslMode);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
