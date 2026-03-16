import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';

import '../core/Font/font_provider.dart';

class TextStyleHelper{
  final BuildContext context;
  TextStyleHelper._(this.context);

  static TextStyleHelper of(BuildContext context) => TextStyleHelper._(context);

  double get _fSS => Provider.of<FontProvider>(context,listen: false).fontSizeScale;
  FontFamilyTypes get _fF => Provider.of<FontProvider>(context,listen: false).fontFamily;

  _fontFamily(){
    switch(_fF){
      case FontFamilyTypes.alexandria: return GoogleFonts.alexandria;
      case FontFamilyTypes.cairo: return GoogleFonts.cairo;
    }
  }

  TextStyle  getTextStyle({required double fontSize,FontWeight? fontWeight}) =>
      _fontFamily()(fontSize: (fontSize*_fSS).sp,fontWeight: fontWeight,color: ThemeClass.of(context).textMainColor);


  TextStyle get s_12Reg => getTextStyle(fontSize: 12);
  TextStyle get s_14Reg => getTextStyle(fontSize: 14);
  TextStyle get s_14W300 => getTextStyle(fontSize: 14,fontWeight: FontWeight.w300);
  TextStyle get s_16Reg => getTextStyle(fontSize: 16);
  TextStyle get s_18Reg => getTextStyle(fontSize: 18);
  TextStyle get s_18W600 => getTextStyle(fontSize: 18,fontWeight: FontWeight.w600);
  TextStyle get s_16W700 => getTextStyle(fontSize: 16,fontWeight: FontWeight.w700);
  TextStyle get s_16W600 => getTextStyle(fontSize: 16,fontWeight: FontWeight.w600);
  TextStyle get s_14W600 => getTextStyle(fontSize: 14,fontWeight: FontWeight.w600);
  TextStyle get s_22W600 => getTextStyle(fontSize: 22,fontWeight: FontWeight.w600);
  TextStyle get s_10Reg => getTextStyle(fontSize: 10);
}