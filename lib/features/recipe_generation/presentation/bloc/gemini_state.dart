part of 'gemini_bloc.dart';

abstract class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object?> get props => [];
}

class GeminiInitial extends GeminiState {}

class GeminiLoading extends GeminiState {}

class GeminiGenerated extends GeminiState {
  final Recipe recipe;

  const GeminiGenerated({required this.recipe});

  @override
  List<Object?> get props => [recipe];
}

class ReceiptRead extends GeminiState {
  final String receiptData; // Change type to String

  const ReceiptRead({required this.receiptData});

  @override
  List<Object?> get props => [receiptData];
}

class GeminiError extends GeminiState {
  final String message;

  const GeminiError({required this.message});

  @override
  List<Object?> get props => [message];
}
