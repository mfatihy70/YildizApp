class Order {
  final int? id;
  final String name;
  final String address;
  final String phone;
  final int milk;
  final int egg;
  final String other;

  Order({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.milk,
    required this.egg,
    required this.other,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      milk: map['milk'],
      egg: map['egg'],
      other: map['other'],
    );
  }
}