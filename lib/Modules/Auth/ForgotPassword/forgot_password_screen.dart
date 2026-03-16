import 'package:sanad_2025/Widgets/custom_textfield_widget.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:sanad_2025/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/strings.dart';
import '../../../Widgets/auth_switch_btn.dart';
import '../../../Widgets/custom_button_widget.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "forgotPassword";

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends StateMVC<ForgotPasswordScreen> {
  _ForgotPasswordScreenState() : super(ForgotPasswordController()) {
    con = ForgotPasswordController();
  }

  late ForgotPasswordController con;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingWidget(
        loading: con.loading,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 37.w),
            child: SizedBox(
              height: 900.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(Assets.imagesLogo, width: 135.r, height: 135.r,)),
                  const Spacer(),
                  // switch btn
                  const AuthSwitchBtnWidget(isLogin: null),
                  const Spacer(),
                  // email
                  CustomTextFieldWidget(
                    hint: Strings.email.tr,
                    prefixIcon: const Icon(Icons.alternate_email),
                    controller: con.emailController,
                  ),
                  const Spacer(),
                  Center(
                    child: CustomButtonWidget.primary(
                      height: 43.h,
                      width: 97.w,
                      radius: 9.r,
                      title: Strings.confirm.tr,
                      onTap:()=> con.forgotPassword(context),
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

