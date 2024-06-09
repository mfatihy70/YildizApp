import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'order_class.dart';
import 'package:provider/provider.dart';
import 'settings/ip_address_notifier.dart';

class DatabaseService {
  late Connection conn;
  bool _isConnected = false;

  Future<void> connect(BuildContext context) async {
    final String host = Provider.of<IpAddressNotifier>(context, listen: false).ipAddress;
    conn = await Connection.open(
      Endpoint(
        host: host,
        database: 'YildizDB',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    _isConnected = true;
    print('Connected to NewDB!');
  }

  Future<void> ensureConnected(BuildContext context) async {
    if (!_isConnected) {
      await connect(context);
    }
  }

  Future<List<Order>> getOrders(BuildContext context) async {
    await ensureConnected(context);
    final result = await conn.execute('SELECT * FROM orders');
    return result.map((row) => Order.fromMap(row.toColumnMap())).toList();
  }

  Future<bool> sendOrder(BuildContext context, Order order) async {
    await ensureConnected(context);
    try {
      await conn.execute(
          "INSERT INTO orders (name, address, phone, milk, egg, other) VALUES ('${order.name}', '${order.address}', '${order.phone}', ${order.milk}, ${order.egg}, '${order.other}')");
      print('Order sent successfully');
      return true;
    } catch (e) {
      print('Failed to send order: $e');
      return false;
    }
  }

  Future<bool> deleteOrder(BuildContext context, int? orderId) async {
    await ensureConnected(context);
    try {
      await conn.execute(
        "DELETE FROM orders WHERE id = $orderId",
      );
      await conn.execute(
        "SELECT setval('orders_id_seq', COALESCE((SELECT MAX(id) FROM orders)+1, 1), false)",
      );
      print("Order deleted successfully");
      return true;
    } catch (e) {
      print('Failed to delete order: $e');
      return false;
    }
  }

  Future<void> close() async {
    await conn.close();
    _isConnected = false;
    print('Connection closed');
  }
}
