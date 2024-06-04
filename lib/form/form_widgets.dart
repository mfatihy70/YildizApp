import 'package:flutter/material.dart';

Widget buildScrollableForm(
    GlobalKey<FormState> formKey, List<Widget> children) {
  return SingleChildScrollView(
    physics: ClampingScrollPhysics(),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: children,
        ),
      ),
    ),
  );
}

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

Widget customButton(int type, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: type == 0
        ? FilledButton(
            onPressed: onPressed,
            child: const Text("Send order"),
          )
        : OutlinedButton(
            onPressed: onPressed,
            child: const Text("Delete last order"),
          ),
  );
}

void showSnackBar(BuildContext context, bool success, String successMessage,
    String failureMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(success ? successMessage : failureMessage),
    ),
  );
}

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
