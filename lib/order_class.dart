class Order {
  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final int milk;
  final int egg;
  final String other;

  Order({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.milk,
    required this.egg,
    required this.other,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      milk: map['milk'],
      egg: map['egg'],
      other: map['other'],
    );
  }
}

// final List<Order> orders = [
//     Order(
//       name: 'IF YOU SEE THIS ',
//       address: '123 Oak St',
//       phoneNumber: '555-1234',
//       milk: 2.0, // Update to double
//       egg: 3,
//       other: 'Juice, Cereal',
//     ),
//     Order(
//       name: 'Sarah Williams',
//       address: '321 Pine St',
//       phoneNumber: '555-3456',
//       milk: 1.5,
//       egg: 24,
//       other: 'Jam, Honey',
//     ),
//     Order(
//       name: 'David Brown',
//       address: '654 Cedar St',
//       phoneNumber: '555-7890',
//       milk: 3.8,
//       egg: 1,
//       other: 'Bread, Butter',
//     ),
//     Order(
//       name: 'Jane Smith',
//       address: '789 Elm St',
//       phoneNumber: '555-5678',
//       milk: 1.5,
//       egg: 12,
//       other: 'Yogurt, Cheese',
//     ),
//     Order(
//       name: 'Michael Johnson',
//       address: '987 Maple St',
//       phoneNumber: '555-9012',
//       milk: 11.4,
//       egg: 2,
//       other: 'Bacon, Sausage',
//     ),
// ];
