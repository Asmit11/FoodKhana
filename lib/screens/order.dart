class Order {
  final String id;
  String item;
  double amount;
  DateTime date;

  Order({
    required this.id,
    required this.item,
    required this.amount,
    required this.date,
  });

  factory Order.example() {
    return Order(
      id: '1',
      item: 'Example Item',
      amount: 100.0,
      date: DateTime.now(),
    );
  }
}
