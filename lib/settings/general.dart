import 'package:flutter/material.dart';

class GeneralMenu extends StatelessWidget {
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
                      ListTile(
                        trailing: Icon(Icons.light_mode),
                        title: Text('Light Theme'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        trailing: Icon(Icons.dark_mode),
                        title: Text('Dark Theme'),
                        onTap: () {
                          Navigator.pop(context);
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
                      ListTile(
                        trailing: Icon(Icons.language),
                        title: Text('Deutsch'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        trailing: Icon(Icons.language),
                        title: Text('Türkçe'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        trailing: Icon(Icons.language),
                        title: Text('English'),
                        onTap: () {
                          Navigator.pop(context);
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
