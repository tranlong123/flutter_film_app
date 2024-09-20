import 'package:flutter_mvvm_riverpod/data/providers/dio_config.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiClient(dio);
});