// lib/core/services/dio_helper.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  // Private constructor
  DioHelper._privateConstructor();

  // Singleton instance
  static final DioHelper _instance = DioHelper._privateConstructor();

  // Public factory method
  factory DioHelper() {
    return _instance;
  }

  // Dio instance
  static late Dio _dio;

  // Initialization method
  static Future<void> initialize() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://your-api-base-url.com', // Set your base URL here
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle responses here
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          // Handle errors here
          return handler.next(error);
        },
      ),
    );
  }

  // Getter for Dio instance
  Dio get dio => _dio;

  // Methods for making HTTP requests
  static Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Failed to get data: ${e.response?.statusCode} ${e.message}');
    }
  }

  static Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Failed to post data: ${e.response?.statusCode} ${e.message}');
    }
  }

  static Future<Response> put(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Failed to put data: ${e.response?.statusCode} ${e.message}');
    }
  }

  static Future<Response> delete(String url,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Failed to delete data: ${e.response?.statusCode} ${e.message}');
    }
  }
}
