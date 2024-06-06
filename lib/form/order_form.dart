import 'package:flutter/material.dart';
import 'form_widgets.dart';
import 'form_functions.dart';
import '../order_class.dart';

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

  String? milkError;
  String? eggError;
  String? otherError;

  void _validateMilkEggOther() {
    setState(() {
      milkError = null;
      eggError = null;
      otherError = null;
    });

    bool isMilkNumeric = int.tryParse(milkController.text) != null;
    bool isEggNumeric = int.tryParse(eggController.text) != null;

    if (!isMilkNumeric) {
      milkError = 'Please enter a number';
    }

    if (!isEggNumeric) {
      eggError = 'Please enter a number';
    }

    if (milkController.text.isEmpty &&
        eggController.text.isEmpty &&
        otherController.text.isEmpty) {
      milkError = eggError = otherError = 'Please give an order';
    }
  }

  void _submitForm() {
    _validateMilkEggOther();

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
        handleSendOrder(context, order, (order) => handleUndoOrder(order));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
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
                labelText: 'Name',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              customTextField(
                controller: addressController,
                labelText: 'Address',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              customTextField(
                controller: phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: customTextField(
                      controller: milkController,
                      labelText: 'Milk',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return milkError;
                      },
                    ),
                  ),
                  Expanded(
                    child: customTextField(
                      controller: eggController,
                      labelText: 'Egg',
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
                labelText: 'Other',
                keyboardType: TextInputType.text,
                validator: (value) {
                  return otherError;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(1, () => handleDeleteLastOrder(context)),
                  customButton(0, _submitForm),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
