import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/views/settings/general/language.dart';
import '/views/settings/general/db_server.dart';
import '/views/settings/general/theme.dart';
import '/controllers/settings/notifiers.dart';
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

    var databaseServerTile = DatabaseServerTile(settingsNotifier: settingsNotifier);

    return ListView(
      children: <Widget>[
        themeTile(context, settingsNotifier),
        languageTile(context, settingsNotifier),
        databaseServerTile
      ],
    );
  }
}
