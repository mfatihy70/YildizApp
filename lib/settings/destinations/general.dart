import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yildiz_app/settings/general/language.dart';
import 'package:yildiz_app/settings/general/server.dart';
import 'package:yildiz_app/settings/general/theme.dart';
import 'package:yildiz_app/settings/notifiers.dart';
import 'package:yildiz_app/localization.dart';

class GeneralSettings extends StatefulWidget {
  @override
  GeneralSettingsState createState() => GeneralSettingsState();
  
  String name(context) => l('general', context);
}

class GeneralSettingsState extends State<GeneralSettings> {
  final _ipController = TextEditingController();
  final _dbNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _dbNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);

    return ListView(
      children: <Widget>[
        themeTile(context, settingsNotifier),
        languageTile(context, settingsNotifier),
        databaseServerTile(context, settingsNotifier)
      ],
    );
  }
}
