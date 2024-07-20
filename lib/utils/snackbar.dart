import 'package:flutter/material.dart';
import '/models/order.dart';
import '/localization/localization.dart';

Future<void> showSnackbar(
  BuildContext context, {
  required Future<bool> Function() action,
  required String successMessage,
  required String failureMessage,
  Future<void> Function(Order?)? undoAction,
  Order? order,
}) async {
  bool success = await action();

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? successMessage : failureMessage),
        action: success && undoAction != null
            ? SnackBarAction(
                label: l('undo', context),
                onPressed: () async {
                  await undoAction(order);
                },
              )
            : null,
      ),
    );
  }
}




