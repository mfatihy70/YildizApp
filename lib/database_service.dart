import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'order_class.dart';
import 'package:provider/provider.dart';
import 'navigation/settings/ip_address_notifier.dart';

class DatabaseService {
  late Connection conn;
  bool _isConnected = false;

  Future<void> connect(BuildContext context) async {
    final String host =
        Provider.of<IpAddressNotifier>(context, listen: false).ipAddress;
    try {
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
      CREATE TABLE IF NOT EXISTS orders
      (
          name character varying(30) COLLATE pg_catalog."default" NOT NULL,
          address character varying(50) COLLATE pg_catalog."default" NOT NULL,
          phone character varying(15) COLLATE pg_catalog."default" NOT NULL,
          milk integer,
          egg integer,
          other character varying(50) COLLATE pg_catalog."default",
          id integer NOT NULL DEFAULT nextval('orders_id_seq'::regclass),
          CONSTRAINT orders_pkey PRIMARY KEY (id)
      ) TABLESPACE pg_default;
    ''');
      await conn.execute('ALTER TABLE IF EXISTS orders OWNER to postgres;');
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
        VALUES ('${order.name}', '${order.address}', '${order.phone}', 
        ${order.milk}, ${order.egg}, '${order.other}')''');

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
      if (orderId == null) {
        await conn.execute(
            "DELETE FROM orders WHERE id = (SELECT MAX(id) FROM orders)");
      }
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
