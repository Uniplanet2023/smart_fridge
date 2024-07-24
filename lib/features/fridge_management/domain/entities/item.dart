import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String name;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final DateTime expiryDate;

  const Item({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.expiryDate,
  });

  @override
  List<Object?> get props => [
        name,
        quantity,
        unitPrice,
        totalPrice,
        expiryDate,
      ];

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : 0.0, // Handle null quantity
      unitPrice: json['unitPrice'] != null
          ? (json['unitPrice'] as num).toDouble()
          : 0.0, // Handle null unitPrice
      totalPrice: json['totalPrice'] != null
          ? (json['totalPrice'] as num).toDouble()
          : 0.0, // Handle null totalPrice
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : DateTime.now(), // Handle null expiryDate
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

  Item copyWith({
    String? name,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? expiryDate,
    DateTime? timeStamp,
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
