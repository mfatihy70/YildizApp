import 'package:flutter/material.dart';
import '/localization/localization.dart';

class NotificationSettings extends StatefulWidget {
  @override
  NotificationSettingsState createState() => NotificationSettingsState();
  String name(context) => l('notifications', context);
}

class NotificationSettingsState extends State<NotificationSettings> {
  bool allowNotifications = false;
  bool playSound = false;
  double soundValue = 50;


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(l('allow_notifications', context)),
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
          title: Text(l('play_sound_notifications', context)),
          trailing: Switch(
            value: playSound,
            onChanged: (value) {
              setState(() {
                playSound = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(l('sound_volume', context), style: TextStyle(fontSize: 16)),
              Slider(
                value: soundValue,
                onChanged: allowNotifications && playSound
                    ? (value) {
                        setState(() {
                          soundValue = value;
                        });
                      }
                    : null,
                min: 0,
                max: 100,
                divisions: 10,
                label: soundValue.round().toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
