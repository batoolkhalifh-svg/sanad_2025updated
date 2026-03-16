import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/custom_textfield_widget.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:sanad_2025/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/strings.dart';
import '../../../Widgets/auth_switch_btn.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../ForgotPassword/forgot_password_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  _LoginScreenState() : super(LoginController()) {
    con = LoginController();
  }

  late LoginController con;


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
                  const AuthSwitchBtnWidget(isLogin: true),
                  const Spacer(),
                  // email
                  CustomTextFieldWidget(
                    hint: Strings.email.tr,
                    prefixIcon: const Icon(Icons.alternate_email),
                    controller: con.emailController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.password.tr,
                    prefixIcon: const Icon(Icons.lock_open),
                    controller: con.passwordController,
                    obscure: true,
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: ()=> context.pushNamed(ForgotPasswordScreen.routeName),
                    child: Text(Strings.forgotPassword.tr,style: TextStyleHelper.of(context).s_14Reg.copyWith(color: ThemeClass.of(context).medGrey),)),

                  const Spacer(),
                  Center(
                    child: CustomButtonWidget.primary(
                      height: 43.h,
                      width: 97.w,
                      radius: 9.r,
                      title: Strings.login.tr,
                      onTap:()=> con.login(context),
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

