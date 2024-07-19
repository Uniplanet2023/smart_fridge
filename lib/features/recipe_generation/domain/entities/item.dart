import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String receiptId;
  final String name;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final DateTime expiryDate;
  final DateTime timeStamp;

  const Item({
    required this.id,
    required this.receiptId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.expiryDate,
    required this.timeStamp,
  });

  @override
  List<Object?> get props => [
        id,
        receiptId,
        name,
        quantity,
        unitPrice,
        totalPrice,
        expiryDate,
        timeStamp,
      ];

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      receiptId: json['receiptId'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      timeStamp: DateTime.parse(json['timeStamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiptId': receiptId,
      'name': name,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'expiryDate': expiryDate.toIso8601String(),
      'timeStamp': timeStamp.toIso8601String(),
    };
  }
}
