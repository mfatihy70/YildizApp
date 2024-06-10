import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class IpAddressNotifier extends ChangeNotifier {
  String _ipAddress = Platform.isAndroid ? '10.0.0.178' : 'localhost';

  String get ipAddress => _ipAddress;

  void updateIpAddress(String newIpAddress) {
    _ipAddress = newIpAddress;
    notifyListeners();
  }
}
