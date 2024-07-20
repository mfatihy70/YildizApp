import 'package:flutter/material.dart';
import 'package:yildiz_app/localization/localization.dart';
import 'package:yildiz_app/widgets/text_field.dart';
import '../controllers/form/validation.dart';

Widget textFields(
  TextEditingController nameC,
  TextEditingController addressC,
  TextEditingController phoneC,
  TextEditingController milkC,
  TextEditingController eggC,
  TextEditingController otherC,
  String? milkError,
  String? eggError,
  String? otherError,
  List<Widget> widgets,
  BuildContext context,
) {
  return Column(
    children: [
      customTextField(
        controller: nameC,
        labelText: l('name', context),
        keyboardType: TextInputType.text,
        validator: (value) => validateName(context, value),
      ),
      customTextField(
        controller: addressC,
        labelText: l('address', context),
        keyboardType: TextInputType.text,
        validator: (value) => validateAddress(context, value),
      ),
      customTextField(
        controller: phoneC,
        labelText: l('phone_number', context),
        keyboardType: TextInputType.phone,
        validator: (value) => validatePhoneNumber(context, value),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: customTextField(
              controller: milkC,
              labelText: l('milk_in_liters', context),
              keyboardType: TextInputType.number,
              validator: (String? value) => milkError,
            ),
          ),
          Expanded(
            child: customTextField(
              controller: eggC,
              labelText: l('egg_in_plates', context),
              keyboardType: TextInputType.number,
              validator: (String? value) => eggError,
            ),
          ),
        ],
      ),
      customTextField(
        controller: otherC,
        labelText: l('other', context),
        keyboardType: TextInputType.text,
        validator: (value) => otherError,
      ),
      ...widgets,
    ],
  );
}
