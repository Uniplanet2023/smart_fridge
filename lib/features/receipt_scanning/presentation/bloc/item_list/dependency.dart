import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/receipt_scanning/data/repository/item_repository_impl.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/item_repository.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/save_items_usecase.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/item_list/item_list_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initItemList() async {
  // Repositories
  serviceLocator
    ..registerFactory<ItemRepository>(
      () => ItemRepositoryImpl(),
    )

    // Use cases
    ..registerFactory(
      () => SaveItemsUseCase(serviceLocator()),
    )

    // Blocs
    ..registerLazySingleton<ItemListBloc>(
      () => ItemListBloc(
        saveItemsUseCase: serviceLocator<SaveItemsUseCase>(),
      ),
    );
}
