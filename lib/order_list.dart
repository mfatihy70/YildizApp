import 'package:flutter/material.dart';
import 'order_class.dart';
import 'database_service.dart';

class OrderList extends StatefulWidget {
  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  final DatabaseService dbService = DatabaseService();
  late Future<List<Order>> orders;
  int selectedIndex = -1; // Add this line

  @override
  void initState() {
    super.initState();
    orders = dbService.getOrders();
  }

  void refreshOrders() {
    setState(() {
      orders = dbService.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: orders,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No orders found'));
                  } else {
                    return buildOrderDataTable(snapshot.data!);
                  }
                } else {
                  return Container(); // Should never be reached
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: refreshOrders,
              mini: true,
              shape: CircleBorder(),
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderDataTable(List<Order> orders) {
    return InteractiveViewer(
      constrained: false,
      scaleEnabled: false,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Milk')),
          DataColumn(label: Text('Egg')),
          DataColumn(label: Text('Others')),
        ],
        rows: orders.asMap().entries.map((entry) {
          int index = entry.key;
          Order order = entry.value;
          return DataRow(
            selected: index == selectedIndex,
            onSelectChanged: (val) {
              setState(() {
                selectedIndex = index;
              });
            },
            cells: [
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