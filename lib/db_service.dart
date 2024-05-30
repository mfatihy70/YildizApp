import 'package:postgres/postgres.dart';
import 'order_class.dart';
import 'dart:io' show Platform;


class DatabaseService {
  late Connection conn;
  final String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';


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

  Future<List<Order>> getOrders() async {
    final result = await conn.execute('SELECT * FROM orders');
    return result.map((row) => Order.fromMap(row.toColumnMap())).toList();
  }

  Future<void> close() async {
    await conn.close();
    print('Connection closed');
  }
}
