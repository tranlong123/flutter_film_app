import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';

mixin BaseViewMixin {
  bool get resizeToAvoidBottomInset => false;

  bool get tapOutsideToDismissKeyBoard => false;

  bool get extendBodyBehindAppBar => false;

  Color? get backgroundColor => bgColor;

  String get screenName;

  Future<bool> onWillPop() async => true;

  Widget buildBody(BuildContext context);

  PreferredSizeWidget? buildAppBar(BuildContext context);

  Widget? buildBottomNavigatorBar(BuildContext context) => null;

  Widget buildView(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: SafeArea(
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: onWillPop,
          child: tapOutsideToDismissKeyBoard
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: buildBody(context),
                )
              : buildBody(context),
        ),
      ),
      bottomNavigationBar: buildBottomNavigatorBar(context),
    );
  }


}
