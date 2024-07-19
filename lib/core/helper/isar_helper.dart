import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/item_model.dart';

class IsarHelper {
  IsarHelper._privateConstructor();

  static final IsarHelper _instance = IsarHelper._privateConstructor();

  static IsarHelper get instance => _instance;

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [ItemModelSchema],
      directory: dir.path,
    );
  }

  Future<void> closeIsar(Isar isar) async {
    await isar.close();
  }
}
