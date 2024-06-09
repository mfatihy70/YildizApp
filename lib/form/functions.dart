import 'package:flutter/material.dart';
import '../order_class.dart';
import 'widgets.dart';
import '../database_service.dart';

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
    milk: int.parse(milkController.text),
    egg: int.parse(eggController.text),
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
      'Order has been sent successfully!',
      'Failed to send order.',
      () => handleUndoOrder(order),
    );
  }
}

// Show snackbar after deleting an order
void deleteSelectedSnackbar(BuildContext context, bool success,
    String successMessage, String errorMessage, VoidCallback onUndo) {
  final snackBar = SnackBar(
    content: Text(success ? successMessage : errorMessage),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: onUndo,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
