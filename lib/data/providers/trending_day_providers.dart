import 'package:flutter_mvvm_riverpod/data/providers/dio_config.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/trending_day/api_trending_day_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiTrendingDayClientProvider = Provider<ApiTrendingDayClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiTrendingDayClient(dio);
});