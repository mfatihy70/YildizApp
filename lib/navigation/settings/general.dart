import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_notifier.dart';
import 'ip_address_notifier.dart';

class GeneralMenu extends StatefulWidget {
  @override
  GeneralMenuState createState() => GeneralMenuState();
}

class GeneralMenuState extends State<GeneralMenu> {
  String _selectedLanguage = 'English';
  final TextEditingController _ipController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  //General ettings components
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
                        groupValue:
                            Provider.of<ThemeNotifier>(context).isDarkMode
                                ? 1
                                : 0,
                        title: Text('Dark Theme'),
                        onChanged: (int? value) {
                          if (value != null) {
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .setDarkMode(true);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      RadioListTile<int>(
                        value: 0,
                        groupValue:
                            Provider.of<ThemeNotifier>(context).isDarkMode
                                ? 1
                                : 0,
                        title: Text('Light Theme'),
                        onChanged: (int? value) {
                          if (value != null) {
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .setDarkMode(false);
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
        ListTile(
          title: Text('Database Server'),
          trailing: Icon(Icons.storage),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Enter IP Address'),
                  content: TextField(
                    controller: _ipController,
                    decoration: InputDecoration(
                      labelText: 'IP Address',
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
                        Provider.of<IpAddressNotifier>(context, listen: false).updateIpAddress(_ipController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
