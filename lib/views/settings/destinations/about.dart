import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/localization/localization.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutSettingsState createState() => AboutSettingsState();
  String name(context) => l('about', context);
}

class AboutSettingsState extends State<AboutPage> {
  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: t('copied_to_clipboard', context),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(l('about_author', context)),
          subtitle: Text('M. Fatih Yıldız'),
        ),
        ListTile(
          title: Text(l('about_version', context)),
          subtitle: Text('0.2.7'),
        ),
        ListTile(
          title: Text(l('about_website', context)),
          subtitle: Text('github.com/mfatihy70/YildizApp'),
          onTap: () =>
              _copyToClipboard('github.com/mfatihy70/YildizApp', context),
          onLongPress: () =>
              _copyToClipboard('github.com/mfatihy70/YildizApp', context),
        ),
        ListTile(
          title: Text(l('about_contact', context)),
          subtitle: Text('yildiz.gida.servis@gmail.com'),
          onTap: () =>
              _copyToClipboard('yildiz.gida.servis@gmail.com', context),
          onLongPress: () =>
              _copyToClipboard('yildiz.gida.servis@gmail.com', context),
        ),
      ],
    );
  }
}
