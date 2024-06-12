import 'package:flutter/material.dart';
import '../order_class.dart';
import '../database_service.dart';
import '../localization.dart';

DatabaseService dbService = DatabaseService();

// Create an order object from the text field controllers
Order createOrder(
    TextEditingController nameController,
    TextEditingController addressController,
    TextEditingController phoneController,
    TextEditingController milkController,
    TextEditingController eggController,
    TextEditingController otherController) {
  return Order(
    name: nameController.text,
    address: addressController.text,
    phone: phoneController.text,
    milk: int.tryParse(milkController.text) ?? 0,
    egg: int.tryParse(eggController.text) ?? 0,
    other: otherController.text,
  );
}

// Handle sending an order to the database while showing a snackbar
Future<void> handleSendOrder(
    BuildContext context, Order order, Function(Order) handleUndoOrder) async {
  bool success = await dbService.sendOrder(context, order);
  if (context.mounted) {
    showSnackBarWithUndo(
      context,
      success,
      l('order_success', context),
      l('order_fail', context),
      () => handleUndoOrder(order),
    );
  }
}

Future<bool> checkDatabaseConnection(BuildContext context) async {
  try {
    await dbService.ensureConnected(context);
    return true;
  } catch (e) {
    // ignore: use_build_context_synchronously
    showConnectionErrorDialog(context, e.toString());
    return false;
  }
}

// Show snackbar after deleting an order
void deleteSelectedSnackbar(BuildContext context, bool success,
    String successMessage, String errorMessage, VoidCallback onUndo) {
  final snackBar = SnackBar(
    content: Text(success ? successMessage : errorMessage),
    action: SnackBarAction(
      label: l('undo', context),
      onPressed: onUndo,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showConnectionErrorDialog(BuildContext context, String message) {
  if (ModalRoute.of(context)?.isCurrent ?? false) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l('connection_error', context)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(l('close', context)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// Show a snackbar with a message
void showSnackBar(BuildContext context, bool success, String successMessage,
    String failureMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(success ? successMessage : failureMessage),
    ),
  );
}

// Show a snackbar with a message and an undo action
void showSnackBarWithUndo(BuildContext context, bool success,
    String successMessage, String failureMessage, VoidCallback undoCallback) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(success ? successMessage : failureMessage),
      action: success
          ? SnackBarAction(
              label: l('undo', context),
              onPressed: undoCallback,
            )
          : null,
    ),
  );
}

// Custom text field widget
Widget customTextField({
  required TextEditingController controller,
  required String labelText,
  required TextInputType keyboardType,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          errorMaxLines: 3,
        ),
        validator: validator),
  );
}
