import 'package:flutter/material.dart';

// Custom text field widget
Widget customTextField({
  required TextEditingController controller,
  required String labelText,
  required TextInputType keyboardType,
  bool obscure = false,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          errorMaxLines: 5,
        ),
        validator: validator),
  );
}
