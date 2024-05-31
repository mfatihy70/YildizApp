import 'package:flutter/material.dart';
import 'order_class.dart';
import 'db_service.dart';

void main() async {
  final dbService = DatabaseService();
  await dbService.connect(); // Wait for the connection to be established
  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService;

  MyApp({required this.dbService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order List',
      darkTheme: ThemeData.dark(),
      home: OrderList(dbService: dbService),
    );
  }
}

class OrderList extends StatefulWidget {
  final DatabaseService dbService;

  OrderList({required this.dbService});

  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: OrderListFutureBuilder(dbService: widget.dbService),
    );
  }
}

class OrderListFutureBuilder extends StatelessWidget {
  final DatabaseService dbService;

  OrderListFutureBuilder({required this.dbService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: dbService.getOrders(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No orders found'));
            } else {
              return OrderDataTable(orders: snapshot.data!);
            }
          default:
            return Container(); // Should never be reached
        }
      },
    );
  }
}

class OrderDataTable extends StatelessWidget {
  final List<Order> orders;

  OrderDataTable({required this.orders});

  @override
  Widget build(BuildContext context) {
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
              DataCell(Text(order.phone)),
              DataCell(Text('${order.milk} liters')),
              DataCell(Text('${order.egg} plates')),
              DataCell(Text(order.other)),
            ],
          );
        }).toList(),
      ),
    );
  }
}