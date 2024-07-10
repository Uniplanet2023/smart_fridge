import 'dart:io';

import 'package:smart_fridge/features/add/data/data_sources/gemini_data_source.dart';
import 'package:smart_fridge/features/add/domain/repository/gemini_repository.dart';

import '../../domain/entities/recipe.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  final GeminiRemoteDataSource remoteDataSource;

  GeminiRepositoryImpl(this.remoteDataSource);

  @override
  Future<Recipe?> generateRecipe(String prompt) async {
    return await remoteDataSource.generateRecipe(prompt);
  }

  @override
  Future<String?> readReceipt(File receiptImage) async {
    return await remoteDataSource.readReceipt(receiptImage);
  }
}
