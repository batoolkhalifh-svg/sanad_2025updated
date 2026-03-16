import 'package:sanad_2025/Utilities/strings.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/custom_button_widget.dart';
import '../generated/assets.dart';

class DialogsHelper{
  final BuildContext context;
  final String message;
  final String? title;

  DialogsHelper({required this.context, required this.message, this.title});


  static BoxDecoration defaultDecoration(BuildContext context) => BoxDecoration(
    border: Border.all(color: Colors.white70),
    borderRadius: BorderRadius.circular(16.r),
    color: ThemeClass.of(context).background,
  );

  Future successDialog() async {}
  Future deleteDialog({required warningMessage,required Function() confirmDelete,Function()? cancel}) async{}
  Future editDialog() async{}
  Future errorDialog({Function()? onTapOk,}) async{
    showGeneralDialog(
      useRootNavigator: true,
      barrierLabel: "",
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 300.r,
            height: 300.r,
            child: Container(
              decoration: defaultDecoration(context),
              padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      height: 70.w,
                      child: Image.asset(
                        Assets.imagesClose,
                        width: 96.r,
                        height: 96.r,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyleHelper.of(context).s_18W600.copyWith(height: 1.4),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButtonWidget.outline(
                    width: 107.w,
                    height: 48.h,
                    radius: 30.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.imagesClose2, width: 20.r, height: 20.r),
                        SizedBox(width: 12.w,),
                        Text(
                          Strings.back.tr,
                          style: TextStyleHelper.of(context).s_16W600.copyWith(color: ThemeClass.of(context).reversedColor),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
