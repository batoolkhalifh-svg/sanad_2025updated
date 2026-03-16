import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_appbar_widget.dart';
import 'about_us_controller.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = "aboutUs";

  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends StateMVC<AboutUsScreen> {
  _AboutUsScreenState() : super(AboutUsController()) {
    con = AboutUsController();
  }

  late AboutUsController con;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(title: Strings.aboutUs.tr,withShadow: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Text(SharedPref.getAppSettings()?.desc??"-",style: TextStyleHelper.of(context).s_16Reg,),
      ),
    );
  }
}

