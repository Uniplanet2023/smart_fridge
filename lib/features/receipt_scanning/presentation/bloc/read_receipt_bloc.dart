import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/core/isar_models/item.dart';
import 'package:smart_fridge/core/notification/schedule_notification.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/read_receipt.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/upload_image.dart';

part 'read_receipt_event.dart';
part 'read_receipt_state.dart';

class ReadReceiptBloc extends Bloc<ReadReceiptEvent, ReadReceiptState> {
  final ReadReceipt readReceipt; // Add the ReadReceipt use case
  final UploadImage uploadImage;

  ReadReceiptBloc({
    required this.readReceipt, // Initialize the ReadReceipt use case
    required this.uploadImage,
  }) : super(ReadReceiptInitial()) {
    on<ScanReceiptEvent>((event, emit) async {
      emit(const ReadingReceipt());
      try {
        // Upload the image and get the URL (if needed)
        // String url = await uploadImage(event.receiptImage);

        // Read the receipt and get JSON data
        final itemJsonData = await readReceipt(event.receiptImage);
        if (itemJsonData == null) {
          emit(const ReadReceiptError(message: 'Failed to read receipt'));
          return;
        }

        // Parse JSON data
        final List<dynamic> parsedJson = jsonDecode(itemJsonData);
        final List<Item> finalResult = parsedJson
            .map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(ReadReceiptCompleted(receiptData: finalResult));
      } catch (e) {
        print(e);
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
