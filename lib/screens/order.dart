class Order {
  final String id;
  String item; // Remove final
  double amount; // Remove final
  DateTime date; // Remove final

  Order({
    required this.id,
    required this.item,
    required this.amount,
    required this.date,
  });
}
