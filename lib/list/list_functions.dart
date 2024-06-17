import 'package:flutter/material.dart';
import 'package:yildiz_app/order_class.dart';
import 'package:yildiz_app/localization.dart';

// Check the connection state and return the appropriate widget
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
        Center(child: Text(l('loading_orders', context)!)),
      ],
    );
  } else if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasError) {
      String errorMessage;
      if (snapshot.error.toString().contains('Failed host lookup')) {
        errorMessage = l('connectivity_error', context)! + snapshot.error.toString();
      } else if (snapshot.error
          .toString()
          .contains('The underlying socket to Postgres')) {
        errorMessage = l('db_connection_error', context)! + snapshot.error.toString();
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
      return Center(child: Text(l('no_orders_found', context)!));
    } else {
      return buildOrderDataTable(
        snapshot.data!,
        selectedIndices,
        onSelectedIndexChange,
        onToggleSelectAll,
        context,
      );
    }
  } else {
    return Container();
  }
}

// Build the data table widget
Widget buildOrderDataTable(
  List<Order> orders,
  List<int> selectedIndices,
  ValueChanged<int> onSelectedIndexChange,
  ValueChanged<bool> onToggleSelectAll,
  BuildContext context,
) {
  return InteractiveViewer(
    constrained: false,
    child: DataTable(
      columnSpacing: 25,
      headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
      columns: [
        DataColumn(label: Text('#')),
        DataColumn(label: Text(l('name', context))),
        DataColumn(label: Text(l('address', context))),
        DataColumn(label: Text(l('phone', context))),
        DataColumn(label: Text(l('milk', context))),
        DataColumn(label: Text(l('egg', context))),
        DataColumn(label: Text(l('others', context))),
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
          onLongPress: () {
            onSelectedIndexChange(index - 1);
          },
          cells: [
            DataCell(Text(index.toString())),
            DataCell(Text(order.name)),
            DataCell(Text(order.address)),
            DataCell(Text(formatPhoneNumber(order.phone))),
            DataCell(
                Center(child: Text(order.milk == 0 ? '' : '${order.milk}'))),
            DataCell(Center(child: Text(order.egg == 0 ? '' : '${order.egg}'))),
            DataCell(Center(child: Text(order.other))),
          ],
        );
      }).toList(),
    ),
  );
}

String formatPhoneNumber(String phone) {
  phone = phone.replaceAll(' ', ''); // Remove any existing spaces
  final originalPhone = phone;

  // Handle phone numbers starting with +43 and having 9 or 10 digits after the prefix

  // Handle phone numbers starting with 0 and having 10 or 11 digits after the prefix
  if (phone.startsWith('0')) {
    if (phone.length == 11) {
      return '${phone.substring(1, 4)} ${phone.substring(4, 7)} ${phone.substring(7)}'; // 680 144 1344
    }
    if (phone.length == 12) {
      return '${phone.substring(1, 4)} ${phone.substring(4, 7)} ${phone.substring(7, 10)} ${phone.substring(10)}'; // 680 144 134 56
    }
  }

  // +43 and other country codes
  if (phone.startsWith('+')) {
    if (phone.startsWith('+43')) {
      if (phone.length == 12) {
        return '${phone.substring(4, 7)} ${phone.substring(7)}'; // 680 144 1344
      }
      if (phone.length == 13) {
        return '${phone.substring(4, 7)} ${phone.substring(7, 10)} ${phone.substring(10)}'; // 680 144 134 56
      }
    } else {
      if (phone.length == 13) {
        return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // +90 555 123 123 23
      }
      if (phone.length == 14) {
        return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // +90 555 123 123 23
      }
    }
  }

  // 10 digits
  if (phone.length == 10) {
    return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6)}'; // 555 123 1234
  }

  // 11 digits
  if (phone.length == 11) {
    return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // 555 123 123 23
  }

  // If none of the conditions match, return the original phone number
  return originalPhone;
}
