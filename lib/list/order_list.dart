import 'package:flutter/material.dart';
import 'package:yildiz_app/order_class.dart';
import 'package:yildiz_app/database_service.dart';
import 'package:yildiz_app/localization.dart';
import 'package:yildiz_app/form/form_functions.dart'
    show deleteSelectedSnackbar;
import 'list_functions.dart';

class OrderList extends StatefulWidget {
  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  final dbService = DatabaseService();
  late Future<List<Order>> orders;
  List<int> selectedIndices = [];
  List<Order> recentlyDeletedOrders = [];
  AsyncSnapshot<List<Order>>? currentSnapshot;

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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: orders,
              builder: (context, snapshot) {
                currentSnapshot = snapshot;
                return connectionCheck(
                  selectedIndices,
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
                  refreshOrders,
                  context,
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
                  onPressed: () {
                    setState(() {
                      if (currentSnapshot?.data != null) {
                        if (selectedIndices.length ==
                            currentSnapshot!.data!.length) {
                          selectedIndices.clear();
                        } else {
                          selectedIndices = List<int>.generate(
                            currentSnapshot!.data!.length,
                            (index) => index,
                          );
                        }
                      }
                    });
                  },
                  child: Text(
                    selectedIndices.isNotEmpty &&
                            selectedIndices.length ==
                                (currentSnapshot?.data?.length ?? 0)
                        ? l('deselect_all', context)
                        : l('select_all', context),
                  ),
                ),
                ElevatedButton(
                  onPressed:
                      selectedIndices.isEmpty ? null : deleteSelectedOrders,
                  child: Text(
                    selectedIndices.isEmpty
                        ? l('delete_selected', context)
                        : '${l('delete_selected', context)} (${selectedIndices.length})',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
