import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/usecases/generate_recipe.dart';
import '../../domain/usecases/read_receipt.dart'; // Import the ReadReceipt use case

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final GenerateRecipe generateRecipe;
  final ReadReceipt readReceipt; // Add the ReadReceipt use case

  GeminiBloc({
    required this.generateRecipe,
    required this.readReceipt, // Initialize the ReadReceipt use case
  }) : super(GeminiInitial()) {
    on<GenerateRecipeEvent>((event, emit) async {
      emit(GeminiLoading());
      try {
        final recipe = await generateRecipe(event.prompt);
        if (recipe != null) {
          emit(GeminiGenerated(recipe: recipe));
        } else {
          emit(const GeminiError(message: 'Failed to generate recipe'));
        }
      } catch (e) {
        emit(GeminiError(message: e.toString()));
      }
    });

    on<ReadReceiptEvent>((event, emit) async {
      emit(GeminiLoading());
      try {
        final receiptData = await readReceipt(event.receiptImage);
        if (receiptData != null) {
          emit(ReceiptRead(receiptData: receiptData));
        } else {
          emit(const GeminiError(message: 'Failed to read receipt'));
        }
      } catch (e) {
        emit(GeminiError(message: e.toString()));
      }
    });
  }
}
