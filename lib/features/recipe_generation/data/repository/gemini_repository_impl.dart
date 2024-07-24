import 'dart:io';

import 'package:smart_fridge/features/recipe_generation/data/data_sources/gemini_data_source.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/gemini_repository.dart';

import '../../domain/entities/recipe.dart';

class ReadReceiptRepositoryImpl implements ReadReceiptRepository {
  final ReadReceiptRemoteDataSource remoteDataSource;

  ReadReceiptRepositoryImpl(this.remoteDataSource);

  @override
  Future<Recipe?> generateRecipe(String prompt) async {
    return await remoteDataSource.generateRecipe(prompt);
  }

  @override
  Future<String?> readReceipt(File receiptImage) async {
    return await remoteDataSource.readReceipt(receiptImage);
  }
}
