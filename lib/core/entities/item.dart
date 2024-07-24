import 'package:isar/isar.dart';

part 'item.g.dart'; // Required for code generation

@Collection()
class Item {
  Id id = Isar.autoIncrement; // Auto increment ID

  @Index()
  late String name;
  late double quantity;
  late double unitPrice;
  late double totalPrice;
  late DateTime expiryDate;

  Item({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.expiryDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  // Add the copyWith method
  Item copyWith({
    String? name,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? expiryDate,
  }) {
    return Item(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
