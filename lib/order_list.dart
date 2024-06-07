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
  List<int> selectedIndices = [];
  List<Order> recentlyDeletedOrders = [];

  @override
  void initState() {
    super.initState();
    orders = dbService.getOrders();
  }

  void refreshOrders() {
    setState(() {
      orders = dbService.getOrders();
      selectedIndices.clear();
    });
  }

  void deleteSelectedOrders() async {
    List<Order> currentOrders = await orders;
    recentlyDeletedOrders = selectedIndices.map((index) => currentOrders[index]).toList();

    for (Order order in recentlyDeletedOrders) {
      await dbService.deleteOrder(order.id);
    }

    refreshOrders();

    if (context.mounted) {
      showSnackBarWithUndo(
        context,
        true,
        'Selected orders have been deleted.',
        'Failed to delete selected orders.',
        undoDelete,
      );
    }
  }

  void undoDelete() async {
    for (Order order in recentlyDeletedOrders) {
      await dbService.sendOrder(order);
    }

    refreshOrders();
    recentlyDeletedOrders.clear();
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
                  onPressed: selectedIndices.isEmpty ? null : deleteSelectedOrders,
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
            'Unable to connect to server. Please check your internet connection or IP address in the settings.';
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

void showSnackBarWithUndo(BuildContext context, bool success, String successMessage, String errorMessage, VoidCallback onUndo) {
  final snackBar = SnackBar(
    content: Text(success ? successMessage : errorMessage),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: onUndo,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
