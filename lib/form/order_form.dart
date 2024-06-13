import 'package:flutter/material.dart';
import 'package:yildiz_app/localization.dart';
import 'package:yildiz_app/order_class.dart';
import 'package:yildiz_app/database_service.dart';
import 'form_functions.dart';
import 'validation.dart';

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final milkController = TextEditingController();
  final eggController = TextEditingController();
  final otherController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final dbService = DatabaseService();

  String? milkError;
  String? eggError;
  String? otherError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(l('order_form', context))),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customTextField(
                controller: nameController,
                labelText: l('name', context),
                keyboardType: TextInputType.text,
                validator: (value) {
                  return validateName(context, value);
                },
              ),
              customTextField(
                controller: addressController,
                labelText: l('address', context),
                keyboardType: TextInputType.text,
                validator: (value) {
                  return validateAddress(context, value);
                },
              ),
              customTextField(
                controller: phoneController,
                labelText: l('phone_number', context),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  return validatePhoneNumber(context, value);
                }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: customTextField(
                      controller: milkController,
                      labelText: l('milk_in_liters', context),
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        return milkError;
                      },
                    ),
                  ),
                  Expanded(
                    child: customTextField(
                      controller: eggController,
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
                controller: otherController,
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
            ],
          ),
        ),
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
        milkController,
        eggController,
        otherController,
        (message) => milkError = message,
        (message) => eggError = message,
        (message) => otherError = message,
        context,
      );
    });

    if (_formKey.currentState?.validate() ?? false) {
      if (milkError == null && eggError == null && otherError == null) {
        Order order = createOrder(
          nameController,
          addressController,
          phoneController,
          milkController,
          eggController,
          otherController,
        );

        // ignore: use_build_context_synchronously
        handleSendOrder(context, order,
            (order) async => await dbService.deleteOrder(context, order.id));
      }
    }
  }
}