import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/read_receipt.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/upload_image.dart';
import '../../domain/entities/recipe.dart';

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

        // Clean the JSON string if it contains unwanted text
        final result =
            itemJsonData.replaceAll('```json', '').replaceAll('```', '').trim();

        // Parse JSON data
        final List<dynamic> parsedJson = jsonDecode(result);
        final List<Item> finalResult = parsedJson
            .map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(ReadReceiptCompleted(receiptData: finalResult));
      } catch (e) {
        print(e);
        emit(ReadReceiptError(message: e.toString()));
      }
    });
  }
}
