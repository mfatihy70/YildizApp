import 'package:flutter/material.dart';
import '/controllers/form/validation.dart';
import '/localization/localization.dart';
import '/models/order.dart';
import '/utils/snackbar.dart';
import '/widgets/text_field.dart';

void editItem(Order order, dbService, refresh, BuildContext context) {
  final nameC = TextEditingController(text: order.name);
  final addressC = TextEditingController(text: order.address);
  final phoneC = TextEditingController(text: order.phone);
  final milkC = TextEditingController(text: order.milk?.toString() ?? '');
  final eggC = TextEditingController(text: order.egg?.toString() ?? '');

  final otherC = TextEditingController(text: order.other);
  final formKey = GlobalKey<FormState>();

  String? milkError;
  String? eggError;
  String? otherError;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
                  bool isConnected = await dbService.ensureConnected(context);

                  if (!isConnected) {
                    return;
                  }

                  validateMilkEggOther(
                    milkC,
                    eggC,
                    otherC,
                    (message) {
                      setState(() {
                        milkError = message;
                      });
                    },
                    (message) {
                      setState(() {
                        eggError = message;
                      });
                    },
                    (message) {
                      setState(() {
                        otherError = message;
                      });
                    },
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

                      showSnackbar(
                        context,
                        action: () async {
                          bool success = await dbService.updateOrder(
                              context, order, newOrder);
                          if (success) {
                            refresh();
                          }
                          return success;
                        },
                        successMessage: l('edit_success', context),
                        failureMessage: l('edit_fail', context),
                        undoAction: (order) async {
                          await dbService.updateOrder(
                              context, newOrder, order);
                          refresh();
                        },
                        order: order,
                      );

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
    },
  );
}
