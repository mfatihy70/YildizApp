import 'package:flutter/material.dart';
//import 'package:yildiz_app/form/textfields.dart';
import 'package:yildiz_app/localization.dart' show l, t;
import 'package:yildiz_app/form/form_functions.dart';
import 'package:yildiz_app/order_class.dart';
import 'package:yildiz_app/form/validation.dart';

void editItem(order, dbService, refresh, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String name = order.name;
      String address = order.address;
      String phoneNum = order.phone;
      String milk = order.milk.toString();
      String egg = order.egg.toString();
      String other = order.other;
      final nameC = TextEditingController(text: name);
      final addressC = TextEditingController(text: address);
      final phoneC = TextEditingController(text: phoneNum);
      final milkC = TextEditingController(text: milk);
      final eggC = TextEditingController(text: egg);
      final otherC = TextEditingController(text: other);
      String? milkError;
      String? eggError;
      String? otherError;

      final formKey = GlobalKey<FormState>();

      return AlertDialog(
        title: t('edit_item', context),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  customTextField(
                    controller: nameC,
                    labelText: l('name', context),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return validateName(context, value);
                    },
                  ),
                  customTextField(
                    controller: addressC,
                    labelText: l('address', context),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return validateAddress(context, value);
                    },
                  ),
                  customTextField(
                    controller: phoneC,
                    labelText: l('phone_number', context),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return validatePhoneNumber(context, value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: customTextField(
                          controller: milkC,
                          labelText: l('milk_in_liters', context),
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            return milkError;
                          },
                        ),
                      ),
                      Expanded(
                        child: customTextField(
                          controller: eggC,
                          labelText: l('egg_in_plates', context),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            return eggError;
                          },
                        ),
                      ),
                    ],
                  ),
                  customTextField(
                    controller: otherC,
                    labelText: l('other', context),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return otherError;
                    },
                  )
                ]),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: t('cancel', context),
          ),
          TextButton(
            onPressed: () async {
              bool isConnected = await checkDatabaseConnection(context);

              if (!isConnected) {
                return;
              }

              validateMilkEggOther(
                milkC,
                eggC,
                otherC,
                (message) => milkError = message,
                (message) => eggError = message,
                (message) => otherError = message,
                // ignore: use_build_context_synchronously
                context,
              );

              if (formKey.currentState?.validate() ?? false) {
                if (milkError == null &&
                    eggError == null &&
                    otherError == null) {
                  // Create an updated order object
                  Order newOrder = Order(
                    name: nameC.text,
                    address: addressC.text,
                    phone: phoneC.text,
                    milk: int.tryParse(milkC.text) ?? order.milk,
                    egg: int.tryParse(eggC.text) ?? order.egg,
                    other: otherC.text,
                  );

                  // Update the order in the database
                  bool updateSuccess =
                      await dbService.updateOrder(context, order, newOrder);

                  if (context.mounted) {
                    showSnackBar(
                      context,
                      updateSuccess,
                      l('edit_success', context),
                      l('edit_fail', context),
                      //() => dbService.updateOrder(context, newOrder, order),
                    );
                  }
                  refresh();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              }
            },
            child: t('save', context),
          )
        ],
      );
    },
  );
}
