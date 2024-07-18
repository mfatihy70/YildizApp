import 'package:flutter/material.dart';
import 'package:yildiz_app/localization/localization.dart' show l, t;
import 'package:yildiz_app/models/order.dart';
import 'package:yildiz_app/models/database.dart';
import 'package:yildiz_app/widgets/text_field.dart';
import 'package:yildiz_app/utils/snackbar.dart';
import 'package:yildiz_app/controllers/form/validation.dart';

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  final nameC = TextEditingController();
  final addressC = TextEditingController();
  final phoneC = TextEditingController();
  final milkC = TextEditingController();
  final eggC = TextEditingController();
  final otherC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? milkError;
  String? eggError;
  String? otherError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: t('order_form', context)),
      ),
      body: Form(
        key: formKey,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
          ),
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.center,
            child: FilledButton(
              onPressed: submitForm,
              child: Text(l("send_order", context)),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> submitForm() async {
    bool isConnected = await dbs.ensureConnected(context);

    if (!isConnected) {
      return;
    }

    setState(() {
      validateMilkEggOther(
        milkC,
        eggC,
        otherC,
        (message) => milkError = message,
        (message) => eggError = message,
        (message) => otherError = message,
        context,
      );
    });

    if (formKey.currentState?.validate() ?? false) {
      if (milkError == null && eggError == null && otherError == null) {
        Order order = Order(
            name: nameC.text,
            address: addressC.text,
            phone: phoneC.text,
            milk: int.tryParse(milkC.text) ?? 0,
            egg: int.tryParse(eggC.text) ?? 0,
            other: otherC.text);

        showSnackbar(
          context,
          action: () async {
            bool result = await dbs.sendOrder(context, order);
            return result;
          },
          undoAction: (order) async {
            bool result = await dbs.deleteOrder(context, order!.id);
            print(result ? "Undo delete successful" : "Undo delete failed");
          },
          successMessage: l('order_success', context),
          failureMessage: l('order_fail', context),
          order: order,
        );
      }
    }
  }
}
