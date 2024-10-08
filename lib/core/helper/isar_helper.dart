import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/data_layer_models/save_recipe_model.dart';

class IsarHelper {
  IsarHelper._privateConstructor();

  static final IsarHelper _instance = IsarHelper._privateConstructor();

  static IsarHelper get instance => _instance;
  static late final Isar isar;

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ItemModelSchema, SaveRecipeModelSchema],
      directory: dir.path,
    );
    return isar;
  }

  Future<void> closeIsar(Isar isar) async {
    await isar.close();
  }
}
