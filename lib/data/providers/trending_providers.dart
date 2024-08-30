import 'package:flutter_mvvm_riverpod/data/providers/dio_config.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/trending/api_trending_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiTrendingClientProvider = Provider<ApiTrendingClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiTrendingClient(dio);
});