import 'dart:developer';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiHelper {
  GeminiHelper._privateConstructor();

  static final GeminiHelper _instance = GeminiHelper._privateConstructor();

  static GeminiHelper get instance => _instance;
  late final GenerativeModel _gemini;

  void initialize(String apiKey) {
    print('Initializing Gemini with API key: $apiKey');
    _gemini = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<String?> generateContent(String prompt) async {
    try {
      final content = [Content.text('Write a story about a magic backpack.')];
      final response = await _gemini.generateContent(content);
      print(response.text);
      return response.text;
    } catch (e) {
      log('Error generating content: $e');
      rethrow;
    }
  }

  Future<String?> generateContentWithImage(String prompt, File image) async {
    try {
      // Read the image bytes
      final firstImage = await image.readAsBytes();

      // Create a TextPart for the prompt
      final textPart = TextPart(prompt);

      // Create DataPart for the image
      final imageParts = [
        DataPart('image/jpeg', firstImage),
      ];

      // Generate content using the multi-part content (text + image)
      final response = await _gemini.generateContent([
        Content.multi([textPart, ...imageParts])
      ]);

      return response.text;
    } catch (e) {
      log('GeminiException: $e');
      rethrow;
    }
  }
}
