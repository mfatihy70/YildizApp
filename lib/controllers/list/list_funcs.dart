part of '/views/list/list_page.dart';

void refreshOrders(OrderListState state) {
  // ignore: invalid_use_of_protected_member
  state.setState(() {
    state.orders = getOrders(state);
    state.selectedIndices.clear();
  });
}

Future<List<Order>> getOrders(OrderListState state) async {
  try {
    return await dbs.getOrders(state.context);
  } catch (e) {
    return Future.error(e);
  }
}

void deleteSelectedOrders(OrderListState state) async {
  List<Order> currentOrders = await state.orders;
  state.recentlyDeletedOrders =
      state.selectedIndices.map((index) => currentOrders[index]).toList();

  bool allDeleted = true;
  for (Order order in state.recentlyDeletedOrders) {
    if (state.mounted) {
      bool success = await dbs.deleteOrder(state.context, order.id);
      if (!success) {
        allDeleted = false;
        break;
      }
    }
  }

  refreshOrders(state);

  if (allDeleted) {
    showSnackbar(
      state.context,
      action: () async => Future.value(true),
      successMessage: l('selected_orders_deleted', state.context),
      failureMessage: l('failed_to_delete_orders', state.context),
      undoAction: (order) async {
        for (Order order in state.recentlyDeletedOrders) {
          bool result = await dbs.sendOrder(state.context, order);
          if (!result) {
            print("Undo delete failed for order: ${order.id}");
            return;
          }
        }
        state.recentlyDeletedOrders.clear();
        refreshOrders(state);
      },
    );
    } else {
    showSnackbar(
      state.context,
      action: () async => Future.value(false),
      successMessage: l('selected_orders_deleted', state.context),
      failureMessage: l('failed_to_delete_orders', state.context),
    );
  }
}

Future<bool> undoDelete(OrderListState state) async {
  try {
    for (Order order in state.recentlyDeletedOrders) {
      bool success = await dbs.sendOrder(state.context, order);
      if (!success) {
        print("Failed to undo delete for order: ${order.id}");
        return false;
      }
    }

    refreshOrders(state);
    state.recentlyDeletedOrders.clear();
    return true;
  } catch (e) {
    print('Failed to undo delete: $e');
    return false;
  }
}