import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';

abstract class SessionRepository {
  List<Movie>? trendingWeekList();

  void saveTrendingWeekList(List<Movie>? trendingWeekList);

  List<Movie>? trendingDayList();

  void saveTrendingDayList(List<Movie>? trendingDayList);
}

class SessionRepositoryImpl implements SessionRepository {
  List<Movie>? _trendingWeekList;

  List<Movie>? _trendingDayList;

  @override
  List<Movie>? trendingWeekList() {
    return _trendingWeekList;
  }

  @override
  void saveTrendingWeekList(List<Movie>? trendingWeekList) {
    _trendingWeekList = trendingWeekList;
  }

  @override
  List<Movie>? trendingDayList() {
    return _trendingDayList;
  }

  @override
  void saveTrendingDayList(List<Movie>? trendingDayList) {
    _trendingDayList = trendingDayList;
  }
}
