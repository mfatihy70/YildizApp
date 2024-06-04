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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: buildScrollableForm(
        _formKey,
        [
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
                  validator: null,
                ),
              ),
              Expanded(
                child: customTextField(
                  controller: eggController,
                  labelText: 'Egg',
                  keyboardType: TextInputType.number,
                  validator: null,
                ),
              ),
            ],
          ),
          customTextField(
            controller: otherController,
            labelText: 'Other',
            keyboardType: TextInputType.text,
            validator: null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(1, () => handleDeleteLastOrder(context)),
              customButton(0, () async {
                if (_formKey.currentState?.validate() ?? false) {
                  Order order = createOrder(
                      nameController,
                      addressController,
                      phoneController,
                      milkController,
                      eggController,
                      otherController);
                  await handleSendOrder(context, order, (order) => handleUndoOrder(order));
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}
