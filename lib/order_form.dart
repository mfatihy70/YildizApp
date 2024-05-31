import 'package:flutter/material.dart';
import 'order_class.dart';
import 'db_service.dart';

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
          padding: EdgeInsets.all(8.0),
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
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: milkController,
                      labelText: 'Milk',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: eggController,
                      labelText: 'Egg',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                controller: otherController,
                labelText: 'Others',
                keyboardType: TextInputType.text,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        dbService.deleteLastOrder();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Last order has been deleted successfully!'),
                          ),
                        );
                      },
                      child: Text("Delete last order"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        Order order = Order(
                          name: nameController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          milk: int.tryParse(milkController.text) ?? 0,
                          egg: int.tryParse(eggController.text) ?? 0,
                          other: otherController.text,
                        );
                        dbService.sendOrder(order);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order has been sent successfully!'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                dbService.deleteOrder(order);
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Send order'),
                    ),
                  ),
                ],
              ),
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
