import 'package:flutter/material.dart';
import '/localization/localization.dart';

String? validateName(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return l('enter_name', context);
  }
  if (value.length < 3) {
    return l('name_min_length', context);
  }
  if (value.length > 50) {
    return l('name_max_length', context);
  }
  return null;
}

String? validateAddress(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return l('enter_address', context);
  }
  if (value.length < 5) {
    return l('address_min_length', context);
  }
  if (value.length > 50) {
    return l('address_max_length', context);
  }
  return null;
}

String? validatePhoneNumber(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return l('enter_phone_number', context);
  }
  if (!RegExp(r'^\+?[\d\s]+$').hasMatch(value)) {
    return l('valid_phone_number', context);
  }
  int numDigits = value.replaceAll(' ', '').length;

  if (numDigits < 10) {
    return l('phone_min_length', context);
  }
  if (numDigits > 15) {
    return l('phone_max_length', context);
  }
  return null;
}

String? validateMilk(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return l('enter_number', context);
  }
  int? parsedValue = int.tryParse(value);
  if (parsedValue == null) {
    return l('valid_number', context);
  } else if (parsedValue > 50) {
    return l('milk_max', context);
  } else if (parsedValue < 5) {
    return l('milk_min', context);
  } else if (parsedValue % 5 != 0) {
    return l('milk_divisible', context);
  }
  return null;
}

String? validateEgg(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return l('enter_number', context);
  }
  int? parsedValue = int.tryParse(value);
  if (parsedValue == null) {
    return l('valid_number', context);
  } else if (parsedValue > 50) {
    return l('egg_max', context);
  }
  return null;
}

String? validateOther(BuildContext context, String? value) {
  if (value != null && value.length > 50) {
    return l('other_max_length', context);
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
  BuildContext context,
) {
  bool allFieldsEmpty = milkController.text.isEmpty &&
      eggController.text.isEmpty &&
      otherController.text.isEmpty;

  bool areMilkEggZero = milkController.text == '0' &&
      eggController.text == '0' &&
      otherController.text.isEmpty;

  if (allFieldsEmpty || areMilkEggZero) {
    setMilkError(l('give_order', context));
    setEggError(l('give_order', context));
    setOtherError(l('give_order', context));
  } else {
    setMilkError(null);
    setEggError(null);
    setOtherError(null);
  }

  if (!allFieldsEmpty) {
    if (milkController.text.isNotEmpty) {
      setMilkError(validateMilk(context, milkController.text));
    }
    if (eggController.text.isNotEmpty) {
      setEggError(validateEgg(context, eggController.text));
    }
    if (otherController.text.isNotEmpty) {
      setOtherError(validateOther(context, otherController.text));
    }
  }
}
