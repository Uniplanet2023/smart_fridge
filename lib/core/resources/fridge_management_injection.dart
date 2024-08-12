// dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/fridge_management/data/data_sources/item_data_source.dart';
import 'package:smart_fridge/features/fridge_management/data/repository/item_repository_impl.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/add_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/delete_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/edit_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/fetch_items_use_case.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';

void setupItem(GetIt serviceLocator) {
  serviceLocator
    // Data sources
    ..registerFactory<ItemDataSource>(() => ItemDataSource())
    // Repositories
    ..registerFactory<ItemRepository>(
      () => ItemRepositoryImpl(serviceLocator<ItemDataSource>()),
    )
    // Use cases
    ..registerFactory(() => AddItemUseCase(serviceLocator<ItemRepository>()))
    ..registerFactory(() => DeleteItemUseCase(serviceLocator<ItemRepository>()))
    ..registerFactory(() => UpdateItemUseCase(serviceLocator<ItemRepository>()))
    ..registerFactory(() => FetchItemsUseCase(serviceLocator<ItemRepository>()))
    // Bloc
    ..registerLazySingleton<FridgeManagementBloc>(() => FridgeManagementBloc(
          addItemUseCase: serviceLocator<AddItemUseCase>(),
          editItemUseCase: serviceLocator<UpdateItemUseCase>(),
          deleteItemUseCase: serviceLocator<DeleteItemUseCase>(),
          fetchItemsUseCase: serviceLocator<FetchItemsUseCase>(),
        ));
  // ViewModel
}
