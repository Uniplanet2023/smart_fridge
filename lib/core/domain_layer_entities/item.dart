class Item {
  final int? id;
  final String name;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final DateTime expiryDate;

  Item({
    this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.expiryDate,
  });

  Item copyWith({
    int? id,
    String? name,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? expiryDate,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
