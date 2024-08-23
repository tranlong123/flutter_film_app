
// Provider cho ApiTrendingWeekClient
import 'package:flutter_mvvm_riverpod/data/providers/dio_config.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/trending/api_trending_week_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiTrendingWeekClientProvider = Provider<ApiTrendingWeekClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiTrendingWeekClient(dio);
});