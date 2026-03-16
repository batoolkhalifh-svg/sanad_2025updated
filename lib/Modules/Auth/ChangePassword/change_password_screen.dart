import 'package:sanad_2025/Widgets/custom_appbar_widget.dart';
import 'package:sanad_2025/Widgets/custom_textfield_widget.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:sanad_2025/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/strings.dart';
import '../../../Widgets/custom_button_widget.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "changePassword";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends StateMVC<ChangePasswordScreen> {
  _ChangePasswordScreenState() : super(ChangePasswordController()) {
    con = ChangePasswordController();
  }

  late ChangePasswordController con;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(title: Strings.changePassword.tr),
      body: LoadingWidget(
        loading: con.loading,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 37.w),
            child: SizedBox(
              height: 800.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(Assets.imagesLogo, width: 135.r, height: 135.r,)),
                  const Spacer(),
                  CustomTextFieldWidget(
                    hint: Strings.oldPassword.tr,
                    prefixIcon: const Icon(Icons.lock_open),
                    obscure: true,
                    controller: con.oldPasswordController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.password.tr,
                    prefixIcon: const Icon(Icons.lock_open),
                    obscure: true,
                    controller: con.newPasswordController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.confirmPassword.tr,
                    prefixIcon: const Icon(Icons.lock_open),
                    obscure: true,
                    controller: con.confirmPasswordController,
                  ),
                  const Spacer(),
                  Center(
                    child: CustomButtonWidget.primary(
                      height: 43.h,
                      width: 97.w,
                      radius: 9.r,
                      title: Strings.confirm.tr,
                      onTap:()=> con.changePassword(context),
                    ),
                  ),
                  const Spacer(flex: 2,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

