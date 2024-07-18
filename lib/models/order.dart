class Order {
  final int? id, milk, egg;
  final String name, address, phone, other;

  Order(
      {this.id,
      required this.name,
      required this.address,
      required this.phone,
      this.milk,
      this.egg,
      required this.other});

  factory Order.fromMap(Map<String, dynamic> map) => Order(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        phone: map['phone'],
        milk: map['milk'],
        egg: map['egg'],
        other: map['other'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'phone': phone,
        'milk': milk,
        'egg': egg,
        'other': other
      };
}
