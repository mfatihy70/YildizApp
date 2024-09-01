import 'package:flutter/material.dart';
import '/models/order.dart';
import '/localization/localization.dart';
import '/models/database.dart';
import '/controllers/list/format_phone.dart';
import 'edit_order.dart';

// Check the connection state and return the buildDataTable
Widget checkConnection(
  List<int> selectedIndices,
  AsyncSnapshot<List<Order>> snapshot,
  ValueChanged<int> onSelectedIndexChange,
  ValueChanged<bool> onToggleSelectAll,
  Function refresh,
  BuildContext context,
) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 16.0),
        Center(child: t('loading_orders', context)!),
      ],
    );
  } else if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasError) {
      String errorMessage;
      if (snapshot.error.toString().contains('Failed host lookup')) {
        errorMessage =
            l('connectivity_error', context)! + snapshot.error.toString();
      } else if (snapshot.error
          .toString()
          .contains('The underlying socket to Postgres')) {
        errorMessage =
            l('db_connection_error', context)! + snapshot.error.toString();
      } else {
        errorMessage = l('generic_error', context)! + snapshot.error.toString();
      }
      return Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      );
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: t('no_orders_found', context)!);
    } else {
      return buildDataTable(
        snapshot.data!,
        selectedIndices,
        onSelectedIndexChange,
        onToggleSelectAll,
        refresh,
        context,
      );
    }
  } else {
    return Container();
  }
}

// Build the data table widget
Widget buildDataTable(
  List<Order> orders,
  List<int> selectedIndices,
  ValueChanged<int> onSelectedIndexChange,
  ValueChanged<bool> onToggleSelectAll,
  Function refresh,
  BuildContext context,
) {
  return InteractiveViewer(
    constrained: false,
    child: DataTable(
      columnSpacing: 25,
      headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
      columns: [
        DataColumn(label: Text('#')),
        DataColumn(label: t('name', context)),
        DataColumn(label: t('address', context)),
        DataColumn(label: t('phone', context)),
        DataColumn(label: t('milk', context)),
        DataColumn(label: t('egg', context)),
        DataColumn(label: t('others', context)),
      ],
      showCheckboxColumn: false,
      rows: orders.asMap().entries.map((entry) {
        int index = entry.key + 1; // Update index dynamically
        Order order = entry.value;
        return DataRow(
          color: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null; // Use the default value.
          }),
          selected: selectedIndices.contains(index - 1),
          onSelectChanged: (val) {
            onSelectedIndexChange(index - 1);
          },
          onLongPress: () => editOrder(order, dbs, refresh, context),
          cells: [
            DataCell(Text(index.toString())),
            DataCell(Text(order.name)),
            DataCell(Text(order.address)),
            DataCell(Text(formatPhoneNumber(order.phone))),
            DataCell(Center(child: Text(order.milk?.toString() ?? ''))),
            DataCell(Center(child: Text(order.egg?.toString() ?? ''))),
            DataCell(Center(child: Text(order.other))),
          ],
        );
      }).toList(),
    ),
  );
}
