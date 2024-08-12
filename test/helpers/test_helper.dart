import 'package:mockito/annotations.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/add_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/delete_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/edit_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/fetch_items_use_case.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/gemini_read_receipt_repository.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/scanned_items_repository.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/read_receipt_use_case.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/save_items_usecase.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/recipe_generation_repository.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/generate_recipe_use_case.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/save_recipe_use_case.dart';

@GenerateMocks([
  ItemRepository,
  ReadReceiptRepository,
  ScannedItemsRepository,
  RecipeRepository,
  AddItemUseCase,
  UpdateItemUseCase,
  DeleteItemUseCase,
  FetchItemsUseCase,
  ReadReceiptUseCase,
  SaveItemsUseCase,
  GenerateRecipeUseCase,
  SaveRecipeUseCase,
])
void main() {}
