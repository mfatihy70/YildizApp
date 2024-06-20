import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutSettingsState createState() => AboutSettingsState();
  String name(context) => l('about', context);
}

class AboutSettingsState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(l('about_author', context)),
          subtitle: Text('M. Fatih Yildiz'),
        ),
        ListTile(
          title: Text(l('about_version', context)),
          subtitle: Text('0.2.4'),
        ),
        ListTile(
          title: Text(l('about_website', context)),
          subtitle: Text('www.github.com/mfatihy70/YildizApp'),
        ),
        ListTile(
          title: Text(l('about_contact', context)),
          subtitle: Text('yildiz.gida.servis@gmail.com'),
        ),
      ],
    );
  }
}