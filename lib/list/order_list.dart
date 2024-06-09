import 'package:flutter/material.dart';
import '../order_class.dart';
import '../database_service.dart';
import '../form/functions.dart' show deleteSelectedSnackbar;

class OrderList extends StatefulWidget {
  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  final DatabaseService dbService = DatabaseService();
  late Future<List<Order>> orders;
  List<int> selectedIndices = [];
  List<Order> recentlyDeletedOrders = [];

  //Initialize the orders list at the start
  @override
  void initState() {
    super.initState();
    orders = dbService.getOrders(context);
  }

  //Refresh the orders list
  void refreshOrders() {
    setState(() {
      orders = dbService.getOrders(context);
      selectedIndices.clear();
    });
  }

  //Delete selected orders
  void deleteSelectedOrders() async {
    List<Order> currentOrders = await orders;
    recentlyDeletedOrders =
        selectedIndices.map((index) => currentOrders[index]).toList();

    for (Order order in recentlyDeletedOrders) {
      if (mounted) {
        await dbService.deleteOrder(context, order.id);
      }
    }

    refreshOrders();

    if (mounted) {
      deleteSelectedSnackbar(
        context,
        true,
        'Selected orders have been deleted.',
        'Failed to delete selected orders.',
        undoDelete,
      );
    }
  }

  //Undo the delete operation
  void undoDelete() async {
    for (Order order in recentlyDeletedOrders) {
      await dbService.sendOrder(context, order);
    }

    refreshOrders();
    recentlyDeletedOrders.clear();
  }

  //Build the components of the order list
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
                return connectionCheck(
                  selectedIndices,
                  context,
                  snapshot,
                  (index) {
                    setState(() {
                      if (selectedIndices.contains(index)) {
                        selectedIndices.remove(index);
                      } else {
                        selectedIndices.add(index);
                      }
                    });
                  },
                  (selectAll) {
                    setState(() {
                      if (selectAll) {
                        selectedIndices = List<int>.generate(
                          snapshot.data?.length ?? 0,
                          (index) => index,
                        );
                      } else {
                        selectedIndices.clear();
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: refreshOrders,
                  mini: true,
                  shape: CircleBorder(),
                  child: const Icon(Icons.refresh),
                ),
                ElevatedButton(
                  onPressed:
                      selectedIndices.isEmpty ? null : deleteSelectedOrders,
                  child: const Text('Delete Selected'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Widget to build the data table of orders
Widget buildOrderDataTable(
  List<Order> orders,
  List<int> selectedIndices,
  ValueChanged<int> onSelectedIndexChange,
  ValueChanged<bool> onToggleSelectAll,
) {
  return InteractiveViewer(
    constrained: false,
    scaleEnabled: false,
    child: DataTable(
      columns: [
        const DataColumn(label: Text('#')),
        const DataColumn(label: Text('Name')),
        const DataColumn(label: Text('Address')),
        const DataColumn(label: Text('Phone')),
        const DataColumn(label: Text('Milk')),
        const DataColumn(label: Text('Egg')),
        const DataColumn(label: Text('Others')),
      ],
      rows: orders.asMap().entries.map((entry) {
        int index = entry.key + 1; // Update index dynamically
        Order order = entry.value;
        return DataRow(
          selected: selectedIndices.contains(index - 1),
          onSelectChanged: (val) {
            onSelectedIndexChange(index - 1);
          },
          cells: [
            DataCell(Text(index.toString())), // Display the updated index
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

//Widget to check the connection status
Widget connectionCheck(
  List<int> selectedIndices,
  BuildContext context,
  AsyncSnapshot<List<Order>> snapshot,
  ValueChanged<int> onSelectedIndexChange,
  ValueChanged<bool> onToggleSelectAll,
) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 16.0),
        Center(child: Text('Loading orders...')),
      ],
    );
  } else if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasError) {
      String errorMessage;
      if (snapshot.error.toString().contains('Failed host lookup')) {
        errorMessage =
            'Can\'t connect to database. Please check your internet connection or database settings.';
      } else {
        errorMessage = 'Error: ${snapshot.error}';
      }
      return Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      );
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No orders found'));
    } else {
      return buildOrderDataTable(
        snapshot.data!,
        selectedIndices,
        onSelectedIndexChange,
        onToggleSelectAll,
      );
    }
  } else {
    return Container();
  }
}