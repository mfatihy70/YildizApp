import 'package:flutter/material.dart';
import 'order_class.dart';
import 'db_service.dart';

class OrderForm extends StatefulWidget {
  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  final dbService = DatabaseService();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final milkController = TextEditingController();
  final eggController = TextEditingController();
  final otherController = TextEditingController();

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
                labelText: 'Other',
                keyboardType: TextInputType.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () async {
                        bool success = await dbService.deleteLastOrder();
                        if (context.mounted) {
                          showSnackBar(context, success, 'Last order has been deleted successfully!', 'Failed to delete last order.');
                        }
                      },
                      child: const Text("Delete last order"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () async {
                        Order order = Order(
                          name: nameController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          milk: int.tryParse(milkController.text) ?? 0,
                          egg: int.tryParse(eggController.text) ?? 0,
                          other: otherController.text,
                        );

                        bool success = await dbService.sendOrder(order);
                        if (context.mounted) {
                        showSnackBarWithUndo(context, success, 'Order has been sent successfully!', 'Failed to send order.', () async {
                          bool undoSuccess = await dbService.deleteOrder(order);
                          if (context.mounted) {
                            showSnackBar(context, undoSuccess, 'Order has been deleted successfully!', 'Failed to delete order.');
                          }
                          });
                        }
                      },
                      child: const Text('Send Order'),
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

void showSnackBar(BuildContext context, bool success, String successMessage, String failureMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(success ? successMessage : failureMessage),
    ),
  );
}

void showSnackBarWithUndo(BuildContext context, bool success, String successMessage, String failureMessage, VoidCallback undoCallback) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(success ? successMessage : failureMessage),
      action: success
          ? SnackBarAction(
              label: 'Undo',
              onPressed: undoCallback,
            )
          : null,
    ),
  );
}
