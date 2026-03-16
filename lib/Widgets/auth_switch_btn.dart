import 'package:sanad_2025/Modules/Auth/Login/login_screen.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../Modules/Auth/Registration/registration_screen.dart';
import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class AuthSwitchBtnWidget extends StatelessWidget {
  final bool? isLogin;
  const AuthSwitchBtnWidget({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354.w,
      height: 50.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: ThemeClass.of(context).primaryColor,)
      ),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: [
          GestureDetector(
            onTap: ()=> context.pushNamed(LoginScreen.routeName),
            child: Container(
              width: 175.w,
              height: 50.h,
              decoration: isLogin != true? null: BoxDecoration(
                color: ThemeClass.of(context).primaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20.r),
                  bottomEnd: Radius.circular(20.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(Strings.login.tr,style: TextStyleHelper.of(context).s_18Reg.copyWith(color:
              isLogin == true?Colors.white: ThemeClass.of(context).primaryColor),),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: ()=> context.pushNamed(RegistrationScreen.routeName),
            child: Container(
              width: 175.w,
              height: 50.h,
              decoration: isLogin != false? null: BoxDecoration(
                color: ThemeClass.of(context).primaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20.r),
                  bottomStart: Radius.circular(20.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(Strings.newAccount.tr,style: TextStyleHelper.of(context).s_18Reg.copyWith(color:
              isLogin == false?Colors.white: ThemeClass.of(context).primaryColor),),
            ),
          ),
        ],
      ),
    );
  }
}
