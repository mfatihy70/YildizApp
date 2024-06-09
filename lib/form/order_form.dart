import 'package:flutter/material.dart';
import 'widgets.dart';
import 'functions.dart';
import '../order_class.dart';

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  //Controllers for the text fields
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final milkController = TextEditingController();
  final eggController = TextEditingController();
  final otherController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //Error messages for the text fields
  String? milkError;
  String? eggError;
  String? otherError;

  //Validation for the order fields
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

  //Submit the form to db after validation
  Future<void> _submitForm() async {
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
        handleSendOrder(context, order,
            (order) async => await dbService.deleteOrder(context, order.id));
      }
    }
  }

  //UI Components for the order form
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
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter a name';
                  // }
                  // if (value.length < 3) {
                  //   return 'Name must be at least 3 characters';
                  // }
                  // if (value.length > 30) {
                  //   return 'Name must be at most 30 characters';
                  // }
                  // return null;
                },
              ),
              customTextField(
                controller: addressController,
                labelText: 'Address',
                keyboardType: TextInputType.text,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter an address';
                  // }
                  // if (value.length < 6) {
                  //   return 'Address must be at least 6 characters';
                  // }

                  // if (value.length > 50) {
                  //   return 'Address must be at most 50 characters';
                  // }
                  // return null;
                },
              ),
              customTextField(
                controller: phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter a phone number';
                  // }
                  // if (!RegExp(r'^\+?\d+$').hasMatch(value)) {
                  //   return 'Please enter a valid phone number';
                  // }
                  // if (value.length < 11) {
                  //   return 'Phone number must be at least 11 digits';
                  // }
                  // if (value.length > 15) {
                  //   return 'Phone number must be at most 15 digits';
                  // }
                  // return null;
                },
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        int? parsedValue = int.tryParse(value!);
                        if (parsedValue == null) {
                          return 'Please enter a valid number';
                        } else if (parsedValue > 50) {
                          return 'Milk orders must be at most 50 liters';
                        } else if (parsedValue < 5) {
                          return 'Please enter a number that is not less than 5';
                        } else if (parsedValue % 5 != 0) {
                          return 'Please enter a number that is divisible by 5';
                        }
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
                        // if (value == null || value.isEmpty) {
                        //   return 'Please enter a number';
                        // }
                        // int? parsedValue = int.tryParse(value!);
                        // if (parsedValue == null) {
                        //   return 'Please enter a valid number';
                        // } else if (parsedValue > 50) {
                        //   return 'Egg orders must be at most 50 plates';
                        // }
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
                  if (value!.length > 50) {
                    return 'Other must be at most 50 characters';
                  }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
