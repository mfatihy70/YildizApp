import 'package:postgres/postgres.dart';
import 'order_class.dart';
import 'dart:io' show Platform;

class DatabaseService {
  late Connection conn;
  final String host = Platform.isAndroid ? '10.0.0.178' : 'localhost';
  bool _isConnected = false;

   Future<void> connect() async {
    conn = await Connection.open(
      Endpoint(
        host: host,
        database: 'NewDB',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    _isConnected = true;
    print('Connected to NewDB!');
  }

  Future<void> ensureConnected() async {
    if (!_isConnected) {
      await connect();
    }
  }

  Future<Order> getOrderById(int id) async {
    await ensureConnected();
    final result = await conn.execute('SELECT * FROM orders WHERE id = $id');
    if (result.isNotEmpty) {
      return Order.fromMap(result.first.toColumnMap());
    }
    throw Exception('Order with ID $id not found');
  }

  Future<List<Order>> getOrders() async {
    await ensureConnected();
    final result = await conn.execute('SELECT * FROM orders');
    return result.map((row) => Order.fromMap(row.toColumnMap())).toList();
  }

  Future<bool> sendOrder(Order order) async {
    await ensureConnected();
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

  Future<bool> deleteOrder(Order order) async {
    await ensureConnected();
    try {
      await conn.execute(
        "DELETE FROM orders WHERE name = '${order.name}' AND address = '${order.address}' AND phone = '${order.phone}' AND milk = ${order.milk} AND egg = ${order.egg} AND other = '${order.other}'",
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

  Future<bool> deleteLastOrder() async {
    await ensureConnected();
    try {
      await conn.execute(
        'DELETE FROM orders WHERE id = (SELECT MAX(id) FROM orders)',
      );
      await conn.execute(
        "SELECT setval('orders_id_seq', COALESCE((SELECT MAX(id) FROM orders)+1, 1), false)",
      );
      print("Last order deleted successfully");
      return true;
    } catch (e) {
      print('Failed to delete last order: $e');
      return false;
    }
  }

  Future<void> close() async {
    await conn.close();
    _isConnected = false;
    print('Connection closed');
  }
}
