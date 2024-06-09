import 'package:flutter/material.dart';


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
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
    ),
  );
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
              label: 'Undo',
              onPressed: undoCallback,
            )
          : null,
    ),
  );
}
