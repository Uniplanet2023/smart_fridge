import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/read_receipt_use_case.dart';

part 'read_receipt_event.dart';
part 'read_receipt_state.dart';

class ReadReceiptBloc extends Bloc<ReadReceiptEvent, ReadReceiptState> {
  final ReadReceiptUseCase readReceiptUseCase;

  ReadReceiptBloc({
    required this.readReceiptUseCase, // Initialize the ReadReceipt use case
  }) : super(ReadReceiptInitial()) {
    on<ScanReceiptEvent>((event, emit) async {
      emit(const ReadingReceipt());
      try {
        // Read the receipt and get list of items data
        final receiptItems = await readReceiptUseCase(event.receiptImage);

        emit(ReadReceiptCompleted(receiptData: receiptItems));
      } catch (e) {
        emit(
          const ReadReceiptError(
            message:
                'There was an error while reading the receipt. Please ensure the image you uploaded is indeed a receipt, or try uploading it again.',
          ),
        );
      }
    });

    @override
    void onChange(Change<ReadReceiptState> change) {
      super.onChange(change);
    }

    @override
    void onTransition(
        Transition<ReadReceiptEvent, ReadReceiptState> transition) {
      super.onTransition(transition);
      print(transition);
    }
  }
}
