import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';
import 'order.dart';
import '/controllers/settings/notifiers.dart';

var dbs = DatabaseService();

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
    final sslMode = n(context).sslMode;

    try {
      conn = await Connection.open(
        Endpoint(
          host: host,
          database: database,
          username: username,
          password: password,
          port: port,
        ),
        settings: ConnectionSettings(
            sslMode: sslMode ? SslMode.require : SslMode.disable),
      );
      _isConnected = true;
      print('Connected to database!');
    } catch (e) {
      _isConnected = false;
      throw Exception('Failed to connect to the database: $e');
    }
  }

  Future<bool> ensureConnected(BuildContext context) async {
    if (!_isConnected) {
      await connect(context);
    }
    return _isConnected;
  }

  Future<List<Order>> getOrders(BuildContext context) async {
    await ensureConnected(context);
    try {
      final result = await conn.execute('SELECT * FROM orders ORDER BY id ASC');
      return result.map((row) => Order.fromMap(row.toColumnMap())).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<bool> createTable(BuildContext context) async {
    await ensureConnected(context);
    try {
      await conn.execute('''
        CREATE TABLE IF NOT EXISTS public.orders(
            id SERIAL PRIMARY KEY,
            name VARCHAR(30) NOT NULL,
            address VARCHAR(50) NOT NULL,
            phone VARCHAR(20) NOT NULL,
            milk INTEGER,
            egg INTEGER,
            other VARCHAR(50)
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
      await createTable(context);
      await conn.execute(Sql.named('''
        INSERT INTO orders (name, address, phone, milk, egg, other) 
        VALUES (@name, @address, @phone, @milk, @egg, @other)
      '''), parameters: {
        'name': order.name,
        'address': order.address,
        'phone': order.phone,
        'milk': order.milk,
        'egg': order.egg,
        'other': order.other,
      });

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
        await conn.execute(Sql.named('DELETE FROM orders WHERE id = @id'),
            parameters: {'id': orderId});
        print("Deleted order with ID: $orderId");
      } else {
        await conn.execute(
            "DELETE FROM orders WHERE id = (SELECT MAX(id) FROM orders)");
        print("Deleted the last order");
      }
      print("Order deleted successfully");
      return true;
    } catch (e) {
      print('Failed to delete order: $e');
      return false;
    }
  }

  Future<bool> updateOrder(
      BuildContext context, Order oldOrder, Order? newOrder) async {
    await ensureConnected(context);
    try {
      await conn.execute(Sql.named('''
        UPDATE orders
        SET name = @name, address = @address, phone = @phone, milk = @milk, egg = @egg, other = @other
        WHERE id = @id
      '''), parameters: {
        'id': oldOrder.id,
        'name': newOrder?.name,
        'address': newOrder?.address,
        'phone': newOrder?.phone,
        'milk': newOrder?.milk,
        'egg': newOrder?.egg,
        'other': newOrder?.other,
      });
      print('Order updated successfully');
      return true;
    } catch (e) {
      print('Failed to update order: $e');
      return false;
    }
  }

  Future<void> close() async {
    await conn.close();
    _isConnected = false;
    print('Connection closed');
  }
}
