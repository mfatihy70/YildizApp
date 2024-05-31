import 'package:postgres/postgres.dart';
import 'order_class.dart';
import 'dart:io' show Platform;


class DatabaseService {
  late Connection conn;
  final String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  DatabaseService() {
    connect();
  }

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
    print('Connected to NewDB!');
  }

  Future<Order> getOrderById(int id) async {
    final result = await conn.execute('SELECT * FROM orders WHERE id = $id');
    if (result.isNotEmpty) {
      return Order.fromMap(result.first.toColumnMap());
    }
    throw Exception('Order with ID $id not found');
  }

  Future<List<Order>> getOrders() async {
    final result = await conn.execute('SELECT * FROM orders');
    return result.map((row) => Order.fromMap(row.toColumnMap())).toList();
  }

  Future<void> sendOrder(Order order) async {
    await conn.execute(
      "INSERT INTO orders (name, address, phone, milk, egg, other) VALUES ('${order.name}', '${order.address}', '${order.phone}', ${order.milk}, ${order.egg}, '${order.other}')"
    );
    print('Order sent successfully');
  }

  Future<void> close() async {
    await conn.close();
    print('Connection closed');
  }
}
