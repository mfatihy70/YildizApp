import 'package:flutter/material.dart';

class NotificationMenu extends StatefulWidget {
  @override
  NotificationMenuState createState() => NotificationMenuState();
}

class NotificationMenuState extends State<NotificationMenu> {
  bool allowNotifications = false;
  bool playSound = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Allow Notifications'),
          trailing: Switch(
            value: allowNotifications,
            onChanged: (value) {
              setState(() {
                allowNotifications = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text('Play sound on notification'),
          trailing: Switch(
            value: playSound,
            onChanged: (value) {
              setState(() {
                playSound = value;
              });
            },
          ),
        ),
      ],
    );
  }
}