import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart' show l, t;
import 'package:yildiz_app/order_class.dart';
import 'package:yildiz_app/database_service.dart';
import 'form_functions.dart';
import 'validation.dart';
//import 'textfields.dart';

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

  final dbService = DatabaseService();

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
              onPressed: _submitForm,
              child: Text(l("send_order", context)),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _submitForm() async {
    bool isConnected = await checkDatabaseConnection(context);

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
        Order order = createOrder(
          nameC,
          addressC,
          phoneC,
          milkC,
          eggC,
          otherC,
        );

        // ignore: use_build_context_synchronously
        handleSendOrder(order, (order) async {
          await dbService.deleteOrder(context, order.id);
        }, context);
      }
    }
  }
}
