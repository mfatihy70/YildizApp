import 'package:flutter/material.dart';
import '/localization/localization.dart';
import '../../../controllers/settings/notifications_helper.dart';

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
  void initState() {
    super.initState();
    _initializeNotifications();
    _checkNotificationPermission();
  }

  Future<void> _initializeNotifications() async {
    await NotificationHelper.initialize();
  }

  Future<void> _checkNotificationPermission() async {
    final status = await NotificationHelper.areNotificationsEnabled();
    setState(() {
      allowNotifications = status;
    });
  }

  Future<void> _requestNotificationPermission() async {
    final status = await NotificationHelper.requestNotificationPermission();
    setState(() {
      allowNotifications = status;
    });

    if (status) {
      _sendNotification(l('notification_settings', context), l('notifications_enabled', context));
    }
  }

  void _sendNotification(String title, String body) {
    NotificationHelper.showNotification(title, body);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(l('allow_notifications', context)),
          trailing: Switch(
            value: allowNotifications,
            onChanged: (value) async {
              if (value) {
                await _requestNotificationPermission();
              } else {
                setState(() {
                  allowNotifications = false;
                });
                _sendNotification(l('notification_settings', context), l('notifications_disabled', context));
              }
            },
          ),
        ),
        ListTile(
          title: Text(l('play_sound_notifications', context)),
          trailing: Switch(
            value: playSound,
            onChanged: allowNotifications
                ? (value) {
                    setState(() {
                      playSound = value;
                    });
                    if (value) {
                      _sendNotification(l('notification_settings', context), l('sound_notifications_enabled', context));
                    } else {
                      _sendNotification(l('notification_settings', context), l('sound_notifications_disabled', context));
                    }
                  }
                : null,
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
