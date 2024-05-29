import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'order_class.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Order List'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Address')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Milk')),
              DataColumn(label: Text('Egg')),
              DataColumn(label: Text('Others')),
            ],
            rows: orders.map((order) => DataRow(
              cells: <DataCell>[
                DataCell(Text(order.name)),
                DataCell(Text(order.address)),
                DataCell(Text(order.phoneNumber)),
                DataCell(Text('${order.milk} liters')),
                DataCell(Text('${order.egg} plates')),
                DataCell(Text(order.other)),
              ],
            )).toList(),
          ),
        ),
      ),
    );
  }
}