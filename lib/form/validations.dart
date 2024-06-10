import 'package:flutter/material.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a name';
  }
  if (value.length < 3) {
    return 'Name must be at least 3 characters';
  }
  if (value.length > 30) {
    return 'Name must be at most 30 characters';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an address';
  }
  if (value.length < 6) {
    return 'Address must be at least 6 characters';
  }
  if (value.length > 50) {
    return 'Address must be at most 50 characters';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }
  if (!RegExp(r'^\+?\d+$').hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  if (value.length < 11) {
    return 'Phone number must be at least 11 digits';
  }
  if (value.length > 15) {
    return 'Phone number must be at most 15 digits';
  }
  return null;
}

String? validateMilk(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  int? parsedValue = int.tryParse(value);
  if (parsedValue == null) {
    return 'Please enter a valid number';
  } else if (parsedValue > 50) {
    return 'Milk orders must\nbe at most 50 liters';
  } else if (parsedValue < 5) {
    return 'Please enter a number\nthat is not less than 5';
  } else if (parsedValue % 5 != 0) {
    return 'Please enter a number\nthat is divisible by 5';
  }
  return null;
}

String? validateEgg(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  int? parsedValue = int.tryParse(value);
  if (parsedValue == null) {
    return 'Please enter a valid number';
  } else if (parsedValue > 50) {
    return 'Egg orders must\nbe at most 50 plates';
  }
  return null;
}

String? validateOther(String? value) {
  if (value != null && value.length > 50) {
    return 'Other must be at most 50 characters';
  }
  return null;
}

void validateMilkEggOther(
  TextEditingController milkController,
  TextEditingController eggController,
  TextEditingController otherController,
  Function(String? message) setMilkError,
  Function(String? message) setEggError,
  Function(String? message) setOtherError,
) {
  bool allFieldsEmpty = milkController.text.isEmpty &&
      eggController.text.isEmpty &&
      otherController.text.isEmpty;

  if (allFieldsEmpty) {
    setMilkError('Please give an order');
    setEggError('Please give an order');
    setOtherError('Please give an order');
  } else {
    setMilkError(null);
    setEggError(null);
    setOtherError(null);
  }

  if (!allFieldsEmpty) {
    if (milkController.text.isNotEmpty) {
      setMilkError(validateMilk(milkController.text));
    }
    if (eggController.text.isNotEmpty) {
      setEggError(validateEgg(eggController.text));
    }
    if (otherController.text.isNotEmpty) {
      setOtherError(validateOther(otherController.text));
    }
  }
}
