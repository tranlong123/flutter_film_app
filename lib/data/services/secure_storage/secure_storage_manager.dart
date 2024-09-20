//không cần thiết
import 'dart:convert';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  SecureStorageManager(this._storage);

  final FlutterSecureStorage _storage;

  static const _trendingWeekList = 'trendingWeek';

  Future<String?> _read({
    required String key,
  }) async {
    return _storage.read(key: key);
  }

  Future<List<Movie>?> readTrendingWeekList() async {
    final result = await _read(key: _trendingWeekList);
    if (result == null) {
      return null;
    } else {
      try {
        final movie = Movie.fromJson(json.decode(result));
        return [movie];
      } catch (_) {
        return null;
      }
    }
  }

  Future<void> _write({
    required String key,
    required String? value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> writeTrendingWeekList(List<Movie>? trendingWeekList) async {
    try {
      await _write(
        key: _trendingWeekList,
        value: json.encode(trendingWeekList),
      );
    } catch (_) {}
  }

  // ignore: unused_element
  Future<void> _delete({
    required String key,
  }) async {
    await _storage.delete(key: key);
  }
}
