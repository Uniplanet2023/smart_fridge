import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiHelper {
  GeminiHelper._privateConstructor();

  static final GeminiHelper _instance = GeminiHelper._privateConstructor();

  static GeminiHelper get instance => _instance;

  void initialize(String apiKey) {
    Gemini.init(apiKey: apiKey);
  }

  Future<String?> generateContent(String prompt) async {
    try {
      final gemini = Gemini.instance;
      final result = await gemini.text(prompt);
      return result?.output;
    } catch (e) {
      rethrow;
    }
  }

  Stream<String> streamGenerateContent(String prompt) {
    final gemini = Gemini.instance;
    return gemini.streamGenerateContent(prompt).map((value) => value.output!);
  }

  Future<String?> generateContentWithImage(String prompt, File image) async {
    try {
      final gemini = Gemini.instance;
      final result = await gemini.textAndImage(
        text: prompt,
        images: [Uint8List.fromList(image.readAsBytesSync())],
      );
      return result?.content?.parts?.last.text;
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> countTokens(String prompt) async {
    try {
      final gemini = Gemini.instance;
      final result = await gemini.countTokens(prompt);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> listModels() async {
    try {
      final gemini = Gemini.instance;
      final models = await gemini.listModels();
      for (var model in models) {
        log(model.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}
