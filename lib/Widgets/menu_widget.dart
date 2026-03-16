import 'package:sanad_2025/Modules/Auth/Login/login_screen.dart';
import 'package:sanad_2025/Modules/Courses/courses_screen.dart';
import 'package:sanad_2025/Modules/Home/home_controller.dart';
import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../Modules/AboutUs/about_us_screen.dart';
import '../Modules/Auth/ChangePassword/change_password_screen.dart';
import '../Modules/ContactUs/contact_us_screen.dart';
import '../Modules/Experts/experts_screen.dart';
import '../Modules/Settings/settings_screen.dart';
import '../Utilities/strings.dart';
import '../core/Language/app_languages.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});


  List<MenuModel> menuItems(BuildContext context)=> [
    MenuModel(title: AppLocalizations.of(context)?.translate(Strings.trendsCourses)??"", onTap: ()=> context.pushNamed(CoursesScreen.routeName)),
    MenuModel(title: Strings.myCourses.tr,
        onTap: ()=> context.pushNamed(CoursesScreen.routeName,extra: true)),
    MenuModel(title: Strings.experts.tr, onTap: ()=> context.pushNamed(ExpertsScreen.routeName)),
    MenuModel(title: Strings.settings.tr, onTap: ()=> context.pushNamed(SettingsScreen.routeName)),
    MenuModel(title: Strings.changePassword.tr, onTap: ()=> context.pushNamed(ChangePasswordScreen.routeName)),
    MenuModel(title: Strings.contactUs.tr, onTap: ()=> context.pushNamed(ContactUsScreen.routeName)),
    MenuModel(title: Strings.aboutUs.tr, onTap: ()=> context.pushNamed(AboutUsScreen.routeName)),
    MenuModel(title: Strings.share.tr, onTap: ()=> Share.share('check sanad app on this line: https://www.sanad.com')),
    MenuModel(title: appLanguage(context) == Languages.en?"العربية":"english",
        onTap: () {
          Provider.of<AppLanguage>(context, listen: false).changeLanguage();
          HomeController().init();
          context.pop();
        }),
    MenuModel(title: Strings.logOut.tr,titleStyle: TextStyleHelper.of(context).s_22W600.copyWith(
      color: ThemeClass.of(context).cancel), onTap: () async{
        await SharedPref.logout();
        if(context.mounted) context.pushNamed(LoginScreen.routeName);
      }),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.r),
          topRight: Radius.circular(50.r)
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: InkWell(
              onTap: ()=> context.pop(),
              child: Icon(Icons.close,color: Colors.black,size: 30.r,)),
          ),
          SizedBox(height: 16.h,),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: menuItems(context).length,
            itemBuilder: (_,index)=> InkWell(
              onTap: menuItems(context)[index].onTap,
              child: Text(menuItems(context)[index].title,
                  style: menuItems(context)[index].titleStyle??TextStyleHelper.of(context).s_22W600),
            ),
            separatorBuilder: (_,i)=> const Divider(),
          ),
          SizedBox(height: 40.h,),
        ],
      ),
    );
  }
}
class MenuModel {
  final String title;
  final TextStyle? titleStyle;
  final Function() onTap;

  MenuModel({required this.title,required this.onTap,this.titleStyle,});
}