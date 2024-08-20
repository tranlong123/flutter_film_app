import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/counter_model.dart';

class CounterViewModel extends StateNotifier<CounterModel> {
  CounterViewModel() : super(CounterModel());

  void increment() {
    state = CounterModel(value: state.value + 1);
  }
}

final counterProvider = StateNotifierProvider<CounterViewModel, CounterModel>((ref) {
  return CounterViewModel();
});
