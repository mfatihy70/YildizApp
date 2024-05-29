import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Form',
      darkTheme: ThemeData(brightness: Brightness.dark,),
      home: OrderForm(),
    );
  }
}

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var milkController = TextEditingController();
  var eggController = TextEditingController();
  var otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextField(
              controller: nameController,
              labelText: 'Name',
              keyboardType: TextInputType.text,
            ),
            CustomTextField(
              controller: addressController,
              labelText: 'Address',
              keyboardType: TextInputType.text,
            ),
            CustomTextField(
              controller: phoneController,
              labelText: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
            CustomTextField(
              controller: milkController,
              labelText: 'Milk Quantity',
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: eggController,
              labelText: 'Egg Quantity',
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: otherController,
              labelText: 'Others',
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () {
                  // Access the text field data
                  print('Name: ${nameController.text}');
                  print('Address: ${addressController.text}');
                  print('Phone Number: ${phoneController.text}');
                  print('Milk Quantity: ${milkController.text}');
                  print('Egg Quantity: ${eggController.text}');
                  print('Others: ${otherController.text}');
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}