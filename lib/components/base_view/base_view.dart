import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_view_mixin.dart';
import 'base_view_model.dart';

abstract class BaseView extends ConsumerStatefulWidget {
  const BaseView({
    super.key,
  });
}

abstract class BaseViewState<View extends BaseView,
        ViewModel extends BaseViewModel> extends ConsumerState<View>
    with BaseViewMixin {
  ViewModel get viewModel;
  @override
  void initState() {
    //Duration.zero
    Future.delayed(Duration.zero, () {
      onInitState();
    });
    super.initState();
  }

  @mustCallSuper
  Future<void> onInitState() async {}

  @override
  Widget build(BuildContext context) => buildView(context);

  @override
  void dispose() {
    super.dispose();
  }
}
