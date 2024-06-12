import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart';

Widget themeTile(BuildContext context, settingsNotifier) {
  return ListTile(
    title: Text(l('app_theme', context)),
    trailing: Icon(Icons.contrast),
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(l('select_theme', context)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile<int>(
                  value: 1,
                  groupValue: settingsNotifier.darkTheme ? 1 : 0,
                  title: Text(l('dark_theme', context)),
                  onChanged: (int? value) {
                    if (value != null) {
                      settingsNotifier.setDarkTheme(true);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<int>(
                  value: 0,
                  groupValue: settingsNotifier.darkTheme ? 1 : 0,
                  title: Text(l('light_theme', context)),
                  onChanged: (int? value) {
                    if (value != null) {
                      settingsNotifier.setDarkTheme(false);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
