import 'package:flutter/material.dart';
import '../order_class.dart';
import 'form_widgets.dart';
import '../database_service.dart';

DatabaseService dbService = DatabaseService();

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


void deleteSelectedSnackbar(BuildContext context, bool success, String successMessage, String errorMessage, VoidCallback onUndo) {
  final snackBar = SnackBar(
    content: Text(success ? successMessage : errorMessage),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: onUndo,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}