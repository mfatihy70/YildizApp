import 'package:flutter/material.dart';
import 'order_class.dart';
import 'db_service.dart';
import 'sys_theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      home: OrderListScreen(),
    );
  }
}

class OrderListScreen extends StatelessWidget {
  final Future<DatabaseService> dbService = dbConnection();

  static Future<DatabaseService> dbConnection() async {
    final dbService = DatabaseService();
    await dbService.connect();
    return dbService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: FutureBuilder<DatabaseService>(
        future: dbService,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data'));
          } else {
            final dbService = snapshot.data!;
            return FutureBuilder<List<Order>>(
              future: dbService.getOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No orders found'));
                } else {
                  final orders = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('#')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Milk')),
                        DataColumn(label: Text('Egg')),
                        DataColumn(label: Text('Others')),
                      ],
                      rows: orders.map((order) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(order.id.toString())),
                            DataCell(Text(order.name)),
                            DataCell(Text(order.address)),
                            DataCell(Text(order.phoneNumber)),
                            DataCell(Text('${order.milk} liters')),
                            DataCell(Text('${order.egg} plates')),
                            DataCell(Text(order.other)),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
