import 'package:sanad_2025/Widgets/custom_textfield_widget.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/strings.dart';
import '../../../Widgets/auth_switch_btn.dart';
import '../../../Widgets/custom_appbar_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../generated/assets.dart';
import 'registration_controller.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "Registration";

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends StateMVC<RegistrationScreen> {
  _RegistrationScreenState() : super(RegistrationController()) {
    con = RegistrationController();
  }

  late RegistrationController con;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBarWidget.detailsScreen(title: ""),
      body: LoadingWidget(
        loading: con.loading,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 800.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(Assets.imagesLogo, width: 135.r, height: 135.r,)),
                  const Spacer(),
                  // switch btn
                  const AuthSwitchBtnWidget(isLogin: false),
                  const Spacer(),
                  // email
                  CustomTextFieldWidget(
                    hint: Strings.email.tr,
                    prefixIcon: const Icon(Icons.alternate_email),
                    controller: con.emailController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.firstName.tr,
                    prefixIcon: const Icon(Icons.person_outline),
                    controller: con.firstNameController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.lastName.tr,
                    prefixIcon: const Icon(Icons.person_outline),
                    controller: con.lastNameController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.mobile.tr,
                    prefixIcon: const Icon(Icons.phone),
                    controller: con.mobileController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.password.tr,
                    prefixIcon: const Icon(Icons.lock_open),
                    controller: con.passwordController,
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextFieldWidget(
                    hint: Strings.confirmPassword.tr,
                    prefixIcon: const Icon(Icons.lock_open),
                    controller: con.confirmPasswordController,
                  ),
                  const Spacer(),
                  CustomButtonWidget.primary(
                    height: 43.h,
                    width: 97.w,
                    radius: 9.r,
                    title: Strings.confirm.tr,
                    onTap: ()=> con.registration(context),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

