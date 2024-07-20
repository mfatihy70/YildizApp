import 'package:flutter/material.dart';
import '/models/order.dart';
import '/models/database.dart';
import '/localization/localization.dart';
import '/utils/snackbar.dart';
import '/views/list/build_table.dart';

part '../../controllers/list/list_funcs.dart';

class OrderList extends StatefulWidget {
  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  late Future<List<Order>> orders;
  List<int> selectedIndices = [];
  List<Order> recentlyDeletedOrders = [];
  AsyncSnapshot<List<Order>>? currentSnapshot;

  @override
  void initState() {
    super.initState();
    orders = getOrders(this);
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
                return checkConnection(
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
                  () => refreshOrders(this),
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
                  onPressed: () => refreshOrders(this),
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
                  onPressed: selectedIndices.isEmpty
                      ? null
                      : () => deleteSelectedOrders(this),
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
