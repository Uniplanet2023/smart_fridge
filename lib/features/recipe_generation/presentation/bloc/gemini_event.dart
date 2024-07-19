part of 'gemini_bloc.dart';

abstract class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object?> get props => [];
}

class GenerateRecipeEvent extends GeminiEvent {
  final String prompt;

  const GenerateRecipeEvent(this.prompt);

  @override
  List<Object?> get props => [prompt];
}

class ReadReceiptEvent extends GeminiEvent {
  final File receiptImage; // Change type to Uint8List

  const ReadReceiptEvent(this.receiptImage);

  @override
  List<Object?> get props => [receiptImage];
}
