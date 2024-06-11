import 'package:flutter/material.dart';

Widget themeTile(BuildContext context, settingsNotifier) {
  return ListTile(
    title: Text('App Theme'),
    trailing: Icon(Icons.contrast),
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile<int>(
                  value: 1,
                  groupValue: settingsNotifier.darkTheme ? 1 : 0,
                  title: Text('Dark Theme'),
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
                  title: Text('Light Theme'),
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
