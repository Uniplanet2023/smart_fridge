part of 'read_receipt_bloc.dart';

abstract class ReadReceiptState extends Equatable {
  const ReadReceiptState();

  @override
  List<Object?> get props => [];
}

class ReadReceiptInitial extends ReadReceiptState {}

class ReadingReceipt extends ReadReceiptState {
  const ReadingReceipt();

  @override
  List<Object?> get props => [];
}

class ReadReceiptCompleted extends ReadReceiptState {
  final List<Item> receiptData;

  const ReadReceiptCompleted({required this.receiptData});

  @override
  List<Object?> get props => [receiptData];
}

class ReadReceiptError extends ReadReceiptState {
  final String message;

  const ReadReceiptError({required this.message});

  @override
  List<Object?> get props => [message];
}
