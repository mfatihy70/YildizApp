import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';

class GeneralMenu extends StatefulWidget {
  @override
  GeneralMenuState createState() => GeneralMenuState();
}

class GeneralMenuState extends State<GeneralMenu> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
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
                        groupValue: Provider.of<ThemeNotifier>(context).isDarkMode ? 1 : 0,
                        title: Text('Dark Theme'),
                        onChanged: (int? value) {
                          if (value != null) {
                            Provider.of<ThemeNotifier>(context, listen: false).setDarkMode(true);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      RadioListTile<int>(
                        value: 0,
                        groupValue: Provider.of<ThemeNotifier>(context).isDarkMode ? 1 : 0,
                        title: Text('Light Theme'),
                        onChanged: (int? value) {
                          if (value != null) {
                            Provider.of<ThemeNotifier>(context, listen: false).setDarkMode(false);
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
        ),
        ListTile(
          title: Text('Language'),
          trailing: Icon(Icons.language),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile<String>(
                        value: 'English',
                        groupValue: _selectedLanguage,
                        title: Text('English'),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedLanguage = value;
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                      RadioListTile<String>(
                        value: 'Deutsch',
                        groupValue: _selectedLanguage,
                        title: Text('Deutsch'),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedLanguage = value;
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                      RadioListTile<String>(
                        value: 'Türkçe',
                        groupValue: _selectedLanguage,
                        title: Text('Türkçe'),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedLanguage = value;
                            });
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
        ),
      ],
    );
  }
}
