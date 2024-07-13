import 'package:isar/isar.dart';
import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@collection
class ItemModel {
  Id id = Isar.autoIncrement; // you can also use a custom id
  late String receiptId;
  late String name;
  late int quantity;
  late double unitPrice;
  late double totalPrice;
  late DateTime expiryDate;
  late DateTime timeStamp;

  Item toEntity() {
    return Item(
      id: id.toString(),
      receiptId: receiptId,
      name: name,
      quantity: quantity,
      unitPrice: unitPrice,
      totalPrice: totalPrice,
      expiryDate: expiryDate,
      timeStamp: timeStamp,
    );
  }

  static ItemModel fromEntity(Item item) {
    return ItemModel()
      ..id = int.parse(item.id)
      ..receiptId = item.receiptId
      ..name = item.name
      ..quantity = item.quantity
      ..unitPrice = item.unitPrice
      ..totalPrice = item.totalPrice
      ..expiryDate = item.expiryDate
      ..timeStamp = item.timeStamp;
  }
}
