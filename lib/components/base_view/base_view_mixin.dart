import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

mixin BaseViewMixin {
  bool get resizeToAvoidBottomInset => false;

  bool get tapOutsideToDismissKeyBoard => false;

  bool get extendBodyBehindAppBar => false;

  Color? get backgroundColor => bgColor;

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
        child: PopScope(
          onPopInvokedWithResult: (disposition, result) {
            // Thực hiện logic khi người dùng nhấn nút Back
            bool shouldPop = true; // Điều kiện xác định có pop hay không

            if (shouldPop) {
              // Thực hiện thao tác cần thiết khi cho phép pop
              // ignore: dead_code
            } else {
              // Ngăn cản pop nếu điều kiện không thỏa mãn
            }
          },
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (() {
              if (tapOutsideToDismissKeyBoard) {
                dismissKeyBoard(context);
              }
            }),
            child: tapOutsideToDismissKeyBoard
                ? SizedBox(
                    width: AppDimensions.screenWidth,
                    height: AppDimensions.screenHeight,
                    child: buildBody(context),
                  )
                : buildBody(context),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigatorBar(context),
    );
  }

  void dismissKeyBoard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
