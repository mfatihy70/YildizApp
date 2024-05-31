import 'package:flutter/material.dart';
import 'order_class.dart';
import 'db_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Form',
      darkTheme: ThemeData.dark(), //getAppTheme(),
      home: OrderForm(),
    );
  }
}

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  var dbService = DatabaseService();

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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
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
                  //style: FilledButton.styleFrom(backgroundColor: Colors.blue,),
                  onPressed: () {
                    Order order = Order(
                      id: 0, // This will be ignored if your DB auto-generates the ID
                      name: nameController.text,
                      address: addressController.text,
                      phone: phoneController.text,
                      milk: int.parse(milkController.text),
                      egg: int.parse(eggController.text),
                      other: otherController.text,
                    );
                    dbService.sendOrder(order);
                    print("sent order");
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
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
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
    ),
  );
}
}