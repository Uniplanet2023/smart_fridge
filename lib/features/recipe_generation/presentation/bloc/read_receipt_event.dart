part of 'read_receipt_bloc.dart';

abstract class ReadReceiptEvent extends Equatable {
  final File receiptImage; // Change type to Uint8List

  const ReadReceiptEvent(this.receiptImage);
  @override
  List<Object?> get props => [];
}

class ScanReceiptEvent extends ReadReceiptEvent {
  const ScanReceiptEvent(super.receiptImage);
}
