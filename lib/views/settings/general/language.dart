import 'package:flutter/material.dart';
import '/localization/localization.dart';

Widget languageTile(context, settingsNotifier) {
  return ListTile(
    title: Text(l('language', context)),
    trailing: Icon(Icons.language),
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(l('select_language', context)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile<String>(
                  value: 'English',
                  groupValue: settingsNotifier.selectedLanguage,
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/flags/en.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text('English'),
                    ],
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      settingsNotifier.setSelectedLanguage(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<String>(
                  value: 'Deutsch',
                  groupValue: settingsNotifier.selectedLanguage,
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/flags/de.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text('Deutsch'),
                    ],
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      settingsNotifier.setSelectedLanguage(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<String>(
                  value: 'Türkçe',
                  groupValue: settingsNotifier.selectedLanguage,
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/flags/tr.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text('Türkçe'),
                    ],
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      settingsNotifier.setSelectedLanguage(value);
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
