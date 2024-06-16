import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';
import 'order_class.dart';
import 'settings/notifiers.dart';

class DatabaseService {
  late Connection conn;
  bool _isConnected = false;

  n(context) => Provider.of<SettingsNotifier>(context, listen: false);

  Future<void> connect(BuildContext context) async {
    final host = n(context).host;
    final database = n(context).dbName;
    final username = n(context).username;
    final password = n(context).password;
    final port = n(context).port;

    try {
      conn = await Connection.open(
        Endpoint(
          host: host,
          database: database,
          username: username,
          password: password,
          port: port,
        ),
        settings: ConnectionSettings(sslMode: SslMode.require),
      );
      _isConnected = true;
      print('Connected to database!');
    } catch (e) {
      _isConnected = false;
      throw Exception('Failed to connect to the database: $e');
    }
  }

  Future<void> ensureConnected(BuildContext context) async {
    if (!_isConnected) {
      await connect(context);
    }
  }

  Future<List<Order>> getOrders(BuildContext context) async {
    await ensureConnected(context);
    try {
      final result = await conn.execute('SELECT * FROM orders');
      return result.map((row) => Order.fromMap(row.toColumnMap())).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<bool> createTable(BuildContext context) async {
    await ensureConnected(context);
    try {
      await conn.execute('CREATE SEQUENCE IF NOT EXISTS orders_id_seq;');
      await conn.execute('''
      CREATE TABLE IF NOT EXISTS public.orders(
          name VARCHAR(30) NOT NULL,
          address VARCHAR(50) NOT NULL,
          phone VARCHAR(20) NOT NULL,
          milk INTEGER,
          egg INTEGER,
          other VARCHAR(50),
          id SERIAL PRIMARY KEY
      );''');
      print('Table created successfully');
      return true;
    } catch (e) {
      print('Failed to create table: $e');
      return false;
    }
  }

  Future<bool> sendOrder(BuildContext context, Order order) async {
    await ensureConnected(context);
    try {
      // ignore: use_build_context_synchronously
      await createTable(context);
      await conn.execute('''
        INSERT INTO orders (name, address, phone, milk, egg, other) 
        VALUES ('${order.name}', '${order.address}', '${order.phone}', '${order.milk}', '${order.egg}', '${order.other}')
      ''');

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
      if (orderId != null) {
        await conn.execute("DELETE FROM orders WHERE id = $orderId");
      } else {
        await conn.execute(
            "DELETE FROM orders WHERE id = (SELECT MAX(id) FROM orders)");
      }
      await conn.execute(
          "SELECT setval('orders_id_seq', COALESCE((SELECT MAX(id) FROM orders)+1, 1), false)");
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
