import 'package:flutter/material.dart';
import '../order_class.dart';
import '../database_service.dart';
import '../form/form_functions.dart' show deleteSelectedSnackbar;
import 'list_functions.dart';
import 'package:yildiz_app/localization.dart';

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
    orders = getOrders();
  }

  void refreshOrders() {
    setState(() {
      orders = getOrders();
      selectedIndices.clear();
    });
  }

  Future<List<Order>> getOrders() async {
    try {
      return await dbService.getOrders(context);
    } catch (e) {
      return Future.error(e);
    }
  }

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
        l('selected_orders_deleted', context),
        l('failed_to_delete_orders', context),
        undoDelete,
      );
    }
  }

  void undoDelete() async {
    for (Order order in recentlyDeletedOrders) {
      await dbService.sendOrder(context, order);
    }

    refreshOrders();
    recentlyDeletedOrders.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(l('order_list', context))),
      ),
      // Display the orders in a data table
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: orders,
              builder: (context, snapshot) {
                // This return gets the orders and builds a table
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
          // Add a row with buttons for refreshing and deleting selected orders
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
                  child: Text(l('delete_selected', context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
