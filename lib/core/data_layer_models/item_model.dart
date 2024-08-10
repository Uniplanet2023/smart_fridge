import 'package:isar/isar.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';

part 'item_model.g.dart'; // Required for code generation

@Collection()
class ItemModel {
  Id id = Isar.autoIncrement; // Auto increment ID

  @Index()
  late String name;
  late double quantity;
  late double unitPrice;
  late double totalPrice;
  late DateTime expiryDate;

  ItemModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.expiryDate,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] != null ? json['id'] as int : Isar.autoIncrement,
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
      'id': id,
      'name': name,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  // Add the copyWith method
  ItemModel copyWith({
    Id? id,
    String? name,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? expiryDate,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  // Convert from domain model to data model
  factory ItemModel.fromDomain(Item item) {
    return ItemModel(
      id: item.id ?? Isar.autoIncrement,
      name: item.name,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      totalPrice: item.totalPrice,
      expiryDate: item.expiryDate,
    );
  }

  // Convert from data model to domain model
  Item toDomain() {
    return Item(
      id: id,
      name: name,
      quantity: quantity,
      unitPrice: unitPrice,
      totalPrice: totalPrice,
      expiryDate: expiryDate,
    );
  }
}
