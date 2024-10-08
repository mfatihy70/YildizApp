import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/views/settings/general/language.dart';
import '../general/database_connection.dart';
import '/views/settings/general/theme.dart';
import '../../../controllers/settings/settings_notifier.dart';
import '/localization/localization.dart' show l;

class GeneralSettings extends StatefulWidget {
  @override
  GeneralSettingsState createState() => GeneralSettingsState();
  String name(context) => l('general', context);
}

class GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);

    var databaseServerTile =
        DatabaseConnectionTile(settingsNotifier: settingsNotifier);

    return ListView(
      children: <Widget>[
        themeTile(context, settingsNotifier),
        languageTile(context, settingsNotifier),
        databaseServerTile
      ],
    );
  }
}
