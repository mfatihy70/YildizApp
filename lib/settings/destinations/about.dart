import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutSettingsState createState() => AboutSettingsState();
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'About';
  }
}

class AboutSettingsState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Author'),
          subtitle: Text('M. Fatih Yildiz'),
        ),
        ListTile(
          title: Text('Version'),
          subtitle: Text('0.1.7'),
        ),
        ListTile(
          title: Text('Website'),
          subtitle: Text('www.github.com/mfatihy70/YildizApp'),
        ),
        ListTile(
          title: Text('Contact'),
          subtitle: Text('yildiz.gida.servis@gmail.com'),
        ),
      ],
    );
  }
}