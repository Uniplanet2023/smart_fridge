import 'package:smart_fridge/core/domain_layer_entities/item.dart';

abstract class ItemRepository {
  Future<void> saveItems(List<Item> items);
}
