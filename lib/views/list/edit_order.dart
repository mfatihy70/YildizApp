import 'package:flutter/material.dart';
import '/controllers/form/validation.dart';
import '/localization/localization.dart';
import '/models/order.dart';
import '/widgets/custom_textfield.dart';
import '/utils/snackbar.dart';

void editOrder(Order order, dbService, refresh, BuildContext context) {
  final nameC = TextEditingController(text: order.name);
  final addressC = TextEditingController(text: order.address);
  final phoneC = TextEditingController(text: order.phone);
  final milkC = TextEditingController(
      text:
          (order.milk == 0 || order.milk == null) ? '' : order.milk.toString());
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
        title: t('edit_order', context),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    children: [
                      Expanded(
                        child: customTextField(
                          controller: milkC,
                          labelText: l('milk_in_liters', context),
                          keyboardType: TextInputType.number,
                          validator: (value) => milkError,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customTextField(
                          controller: eggC,
                          labelText: l('egg_in_plates', context),
                          keyboardType: TextInputType.number,
                          validator: (value) => eggError,
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
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: t('cancel', context),
          ),
          TextButton(
            onPressed: () async {
              bool isConnected = await dbService.ensureConnected(context);
              if (!isConnected) return;

              validateMilkEggOther(
                milkC,
                eggC,
                otherC,
                (message) => milkError = message,
                (message) => eggError = message,
                (message) => otherError = message,
                context,
              );

              if (formKey.currentState?.validate() ?? false) {
                if (milkError == null &&
                    eggError == null &&
                    otherError == null) {
                  Order newOrder = Order(
                    id: order.id,
                    name: nameC.text,
                    address: addressC.text,
                    phone: phoneC.text,
                    milk: int.tryParse(milkC.text),
                    egg: int.tryParse(eggC.text),
                    other: otherC.text,
                  );

                  bool updateSuccess =
                      await dbService.updateOrder(context, order, newOrder);

                  if (context.mounted) {
                    showSnackBarWithUndo(
                      updateSuccess,
                      l('edit_success', context),
                      l('edit_fail', context),
                      () async {
                        await dbService.updateOrder(
                            context, newOrder, originalOrder);
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
          ),
        ],
      );
    },
  );
}
