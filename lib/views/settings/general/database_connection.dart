import 'package:flutter/material.dart';
import '/localization/localization.dart';
import '../../../controllers/settings/settings_notifier.dart';
import '/widgets/custom_textfield.dart';

class DatabaseConnectionTile extends StatefulWidget {
  final SettingsNotifier settingsNotifier;

  DatabaseConnectionTile({required this.settingsNotifier});

  @override
  DatabaseConnectionTileState createState() => DatabaseConnectionTileState();
}

class DatabaseConnectionTileState extends State<DatabaseConnectionTile> {
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
                        customTextField(
                          controller: hostC,
                          labelText: l('host', context),
                          keyboardType: TextInputType.text,
                        ),
                        customTextField(
                          controller: portC,
                          labelText: l('port', context),
                          keyboardType: TextInputType.number,
                        ),
                        customTextField(
                          controller: dbNameC,
                          labelText: l('database_name', context),
                          keyboardType: TextInputType.text,
                        ),
                        customTextField(
                          controller: usernameC,
                          labelText: l('username', context),
                          keyboardType: TextInputType.text,
                        ),
                        customTextField(
                          controller: passwordC,
                          labelText: l('password', context),
                          keyboardType: TextInputType.text,
                          obscure: true,
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
                        // Notify the settings notifier to update the database connection settings.
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
