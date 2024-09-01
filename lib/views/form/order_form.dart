import 'package:flutter/material.dart';
import '/localization/localization.dart' show l, t;
import '/models/order.dart';
import '/models/database.dart';
import '/widgets/custom_textfield.dart';
import '/utils/snackbar.dart';
import '/controllers/form/validation.dart';

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

// This class creates a form to submit an order.
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

  // This function builds the form with text fields for user input.
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

  // This function is responsible for submitting the form data to create a new order.
  Future<void> submitForm() async {
    // First, check if the device is connected to the internet or the required network.
    bool isConnected = await dbs.ensureConnected(context);

    // If not connected, simply return and do not proceed with form submission.
    if (!isConnected) {
      return;
    }

    // Update the UI state to validate the inputs for milk, egg, and other categories.
    // This involves setting error messages if the validation fails.
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

    // Check if the form is in a valid state (all required fields are filled and valid).
    if (formKey.currentState?.validate() ?? false) {
      // Further check if there are no error messages for milk, egg, and other inputs.
      if (milkError == null && eggError == null && otherError == null) {
        // Create a new Order object with the form inputs.
        Order order = Order(
            name: nameC.text,
            address: addressC.text,
            phone: phoneC.text,
            milk: int.tryParse(milkC.text) ?? 0,
            egg: int.tryParse(eggC.text) ?? 0,
            other: otherC.text);

        // Show a snackbar with a success or failure message after attempting to send the order.
        // This also includes an undo action to delete the order if needed.
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
