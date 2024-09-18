import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'loading_state.dart';

final loadingStateProvider =
    StateNotifierProvider<LoadingStateViewModel, LoadingState>(
        (ref) => LoadingStateViewModel(ref));

class LoadingStateViewModel extends StateNotifier<LoadingState> {
  LoadingStateViewModel(this.ref) : super(LoadingState());

  final Ref ref;

  Future<bool> whileLoading(
    BuildContext context,
    Future Function() future,
  ) async {
    await Future.microtask(toLoading)
        .then((_) => future())
        .whenComplete(toIdle);
    return true;
  }

  void toLoading() {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
  }

  void toIdle() {
    if (!state.isLoading) return;
    state = state.copyWith(isLoading: false);
  }
}
