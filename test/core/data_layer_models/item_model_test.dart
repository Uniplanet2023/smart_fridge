import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';

import '../../helpers/json_reader.dart';

void main() {
  late ItemModel testItemModel;

  setUp(() {
    testItemModel = ItemModel(
      name: "Banana",
      quantity: 1.0,
      unitPrice: 0.0,
      totalPrice: 0.0,
      expiryDate: DateTime.parse("2024-04-13T08:30:00Z").toUtc(),
    );
  });

  test('Should convert to Item entity in domain layer', () {
    // Act
    final item = testItemModel.toDomain();

    // Assert
    expect(item.id, testItemModel.id);
    expect(item.name, testItemModel.name);
    expect(item.quantity, testItemModel.quantity);
    expect(item.unitPrice, testItemModel.unitPrice);
    expect(item.totalPrice, testItemModel.totalPrice);
    expect(item.expiryDate, testItemModel.expiryDate);
  });

  test(
      'Should convert from Item entity in domain layer to ItemModel in data layer',
      () {
    // Arrange
    final domainItem = Item(
      id: testItemModel.id,
      name: testItemModel.name,
      quantity: testItemModel.quantity,
      unitPrice: testItemModel.unitPrice,
      totalPrice: testItemModel.totalPrice,
      expiryDate: testItemModel.expiryDate,
    );

    // Act
    final itemModel = ItemModel.fromDomain(domainItem);

    // Assert
    expect(itemModel.id, domainItem.id);
    expect(itemModel.name, domainItem.name);
    expect(itemModel.quantity, domainItem.quantity);
    expect(itemModel.unitPrice, domainItem.unitPrice);
    expect(itemModel.totalPrice, domainItem.totalPrice);
    expect(itemModel.expiryDate, domainItem.expiryDate);
  });

  test('Should return a valid Item Model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json
        .decode(readJson('helpers/dummy_data/dummy_item_response.json'));

    // act
    final result = ItemModel.fromJson(jsonMap);

    // Assert
    expect(result.name, testItemModel.name);
    expect(result.quantity, testItemModel.quantity);
    expect(result.unitPrice, testItemModel.unitPrice);
    expect(result.totalPrice, testItemModel.totalPrice);

    // Compare only up to seconds to avoid millisecond mismatches
    expect(
        result.expiryDate.isAtSameMomentAs(testItemModel.expiryDate), isTrue);
  });
}
