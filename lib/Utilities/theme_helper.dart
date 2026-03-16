import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/Theme/theme_model.dart';
import '../core/Theme/theme_provider.dart';

class ThemeClass extends ThemeModel{

  static ThemeModel of(BuildContext context) => Provider.of<ThemeProvider>(context,listen: false).appTheme;


  ThemeClass.lightTheme({
    super.isDark = false,
    super.background = const Color(0xffFFFFFF),
    super.primaryColor = const Color(0xffE1001F),
    super.pTint1 = const Color(0xff9FDEDF),
    super.pTint2 = const Color(0xffC6EBEC),
    super.pShade1 = const Color(0xff082B2B),
    super.secondary = const Color(0xff3098A7),
    super.sTint1 = const Color(0xffFDEA7E),
    super.sTint2 = const Color(0xffFEF6C4),
    super.shade1 = const Color(0xff322B04),
    super.cardLight = const Color(0xffF4F4F5),
    super.lightGrey = const Color(0xffD9D9D9),
    super.medGrey = const Color(0xff707070),
    super.darkGrey = const Color(0xff606060),
    super.success = const Color(0xff008F5D),
    super.waiting = const Color(0xffF68524),
    super.cancel = const Color(0xffEA3829),
    super.informative = const Color(0xff3892F3),
    super.textMainColor = const Color(0xff222222),
    super.textSecondaryColor = const Color(0xff606060),
    super.reversedColor = const Color(0xff121212),
  });

  ThemeClass.darkTheme({
    super.isDark = true,
    super.background = const Color(0xff111219),
    super.primaryColor = const Color(0xff01A5A7),
    super.pTint1 = const Color(0xff9FDEDF),
    super.pTint2 = const Color(0xffC6EBEC),
    super.pShade1 = const Color(0xffffffff),
    super.secondary = const Color(0xffEFBF1E),
    super.sTint1 = const Color(0xffFDEA7E),
    super.sTint2 = const Color(0xffFEF6C4),
    super.shade1 = const Color(0xff322B04),
    super.cardLight = const Color(0xff191C2F),
    super.lightGrey = const Color(0xffD9D9D9),
    super.medGrey = const Color(0xff707070),
    super.darkGrey = const Color(0xff606060),
    super.success = const Color(0xff008F5D),
    super.waiting = const Color(0xffF68524),
    super.cancel = const Color(0xffEA3829),
    super.informative = const Color(0xff3892F3),
    super.textMainColor = const Color(0xffdedede),
    super.textSecondaryColor = const Color(0xffD9D9D9),
    super.reversedColor = const Color(0xfffefefe),
  });
}