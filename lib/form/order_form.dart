import 'package:flutter/material.dart';
import 'widgets.dart';
import 'functions.dart';
import '../order_class.dart';
import '../database_service.dart'; // Ensure to import DatabaseService
import 'validations.dart'; // Import the validations

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

  final DatabaseService dbService = DatabaseService();

  String? milkError;
  String? eggError;
  String? otherError;

  Future<bool> _checkDatabaseConnection(BuildContext context) async {
    try {
      await dbService.ensureConnected(context);
      return true;
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showConnectionErrorDialog(context, e.toString());
      return false;
    }
  }

  void _showConnectionErrorDialog(BuildContext context, String message) {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection Error'),
            content: Text('Failed to connect to the database: $message'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _submitForm() async {
    bool isConnected = await _checkDatabaseConnection(context);

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
            (order) async => await dbService.deleteOrder(context, order.id));//deleteLastOrder(context));
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
                validator: validateName,
              ),
              customTextField(
                controller: addressController,
                labelText: 'Address',
                keyboardType: TextInputType.text,
                validator: validateAddress,
              ),
              customTextField(
                controller: phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: validatePhoneNumber,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: customTextField(
                      controller: milkController,
                      labelText: 'Milk in liters',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return milkError;
                      },
                    ),
                  ),
                  Expanded(
                    child: customTextField(
                      controller: eggController,
                      labelText: 'Egg in plates',
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
              Container(
                alignment: Alignment.center,
                child: FilledButton(
                  onPressed: _submitForm,
                  child: const Text("Send order"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
