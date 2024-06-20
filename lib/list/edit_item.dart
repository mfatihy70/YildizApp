import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart' show l, t;
import 'package:yildiz_app/form/form_functions.dart';
import 'package:yildiz_app/order_class.dart';
import 'package:yildiz_app/form/validation.dart';

void editItem(Order order, dbService, refresh, BuildContext context) {
  final nameC = TextEditingController(text: order.name);
  final addressC = TextEditingController(text: order.address);
  final phoneC = TextEditingController(text: order.phone);
  final milkC = TextEditingController(
      text: (order.milk == 0 || order.milk == null) ? '' : order.milk.toString());
  final eggC = TextEditingController(
      text: (order.egg == 0 || order.egg == null) ? '' : order.egg.toString());
  final otherC = TextEditingController(text: order.other);
  final formKey = GlobalKey<FormState>();
  String? milkError;
  String? eggError;
  String? otherError;

  // Clone the original order
  Order originalOrder = Order(
    id: order.id,
    name: order.name,
    address: order.address,
    phone: order.phone,
    milk: order.milk,
    egg: order.egg,
    other: order.other,
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
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
                    id: order.id,
                    name: nameC.text,
                    address: addressC.text,
                    phone: phoneC.text,
                    milk: int.tryParse(milkC.text),
                    egg: int.tryParse(eggC.text),
                    other: otherC.text,
                  );

                  // Update the order in the database
                  bool updateSuccess =
                      await dbService.updateOrder(context, order, newOrder);

                  if (context.mounted) {
                    showSnackBarWithUndo(
                      updateSuccess,
                      l('edit_success', context),
                      l('edit_fail', context),
                      () async {
                        await dbService.updateOrder(context, newOrder, originalOrder);
                        refresh();
                      },
                      context,
                    );
                  }
                  refresh();
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
