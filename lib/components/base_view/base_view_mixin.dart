import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

mixin BaseViewMixin {
  bool get resizeToAvoidBottomInset => false;

  bool get tapOutsideToDismissKeyBoard => false;

  bool get extendBodyBehindAppBar => false;

  Color? get backgroundColor => bgColor;

  Future<bool> onWillPop() async => true;

  Widget buildBody(BuildContext context);

  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget? buildBottomNavigatorBar(BuildContext context) => null;

  Widget buildView(BuildContext context) {
    AppDimensions.init(context);
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
                  width: AppDimensions.screenWidth,
                  height:AppDimensions.screenHeight,
                  child: buildBody(context),
                )
              : buildBody(context),
        ),
      ),
      bottomNavigationBar: buildBottomNavigatorBar(context),
    );
  }
}
