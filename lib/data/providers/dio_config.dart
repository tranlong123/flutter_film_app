import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Dio createDio() {
  final dio = Dio();
  dio.options = BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
  connectTimeout: const Duration(milliseconds: 5000),  
  receiveTimeout: const Duration(milliseconds: 3000),  
  );
  return dio;
}
// Provider cho Dio
final dioProvider = Provider<Dio>((ref) {
  return createDio();
});
