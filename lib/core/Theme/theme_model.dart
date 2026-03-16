import 'package:flutter/material.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/theme_helper.dart';


class ThemeModel extends ThemeExtension<ThemeModel>{

  static ThemeModel defaultTheme = ThemeClass.lightTheme();

  final bool isDark;
  final Color background;
  final Color primaryColor;
  final Color pTint1;
  final Color pTint2;
  final Color pShade1;
  final Color secondary;
  final Color sTint1;
  final Color sTint2;
  final Color shade1;
  final Color cardLight;
  final Color lightGrey;
  final Color medGrey;
  final Color darkGrey;
  final Color success;
  final Color waiting;
  final Color cancel;
  final Color informative;
  final Color textMainColor;
  final Color textSecondaryColor;
  final Color reversedColor;


  ThemeModel({
    this.isDark = false,
    required this.background,
    required this.primaryColor,
    required this.pTint1,
    required this.pTint2,
    required this.pShade1,
    required this.secondary,
    required this.sTint1,
    required this.sTint2,
    required this.shade1,
    required this.cardLight,
    required this.lightGrey,
    required this.medGrey,
    required this.darkGrey,
    required this.success,
    required this.waiting,
    required this.cancel,
    required this.informative,
    required this.textMainColor,
    required this.textSecondaryColor,
    required this.reversedColor,
  });

  @override
  ThemeModel copyWith({
    bool? isDark,
    Color? background,
    Color? primaryColor,
    Color? pTint1,
    Color? pTint2,
    Color? pShade1,
    Color? secondary,
    Color? sTint1,
    Color? sTint2,
    Color? shade1,
    Color? cardLight,
    Color? lightGrey,
    Color? medGrey,
    Color? darkGrey,
    Color? success,
    Color? waiting,
    Color? cancel,
    Color? informative,
    Color? textMainColor,
    Color? textSecondaryColor,
    Color? reversedColor,
  }) {
    return ThemeModel(
      isDark: isDark??this.isDark,
      background: background??this.background,
      primaryColor: primaryColor??this.primaryColor,
      pTint1: pTint1??this.pTint1,
      pTint2: pTint2??this.pTint2,
      pShade1: pShade1??this.pShade1,
      secondary: secondary??this.secondary,
      sTint1: sTint1??this.sTint1,
      sTint2: sTint2??this.sTint2,
      shade1: shade1??this.shade1,
      cardLight: cardLight??this.cardLight,
      lightGrey: lightGrey??this.lightGrey,
      medGrey: medGrey??this.medGrey,
      darkGrey: darkGrey??this.darkGrey,
      success: success??this.success,
      waiting: waiting??this.waiting,
      cancel: cancel??this.cancel,
      informative: informative??this.informative,
      textMainColor: textMainColor??this.textMainColor,
      textSecondaryColor: textSecondaryColor??this.textSecondaryColor,
      reversedColor: reversedColor??this.reversedColor,
    );
  }

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
    isDark: json["isDark"],

    background: Color(json["background"]),
    primaryColor: Color(json["primaryColor"]),
    pTint1: Color(json["pTint1"]),
    pTint2: Color(json["pTint2"]),
    pShade1: Color(json["pShade1"]),
    secondary: Color(json["secondary"]),
    sTint1: Color(json["sTint1"]),
    sTint2: Color(json["sTint2"]),
    shade1: Color(json["shade1"]),
    cardLight: Color(json["cardLight"]),
    lightGrey: Color(json["lightGrey"]),
    medGrey: Color(json["medGrey"]),
    darkGrey: Color(json["darkGrey"]),
    success: Color(json["success"]),
    waiting: Color(json["waiting"]),
    cancel: Color(json["cancel"]),
    informative: Color(json["informative"]),
    textMainColor: Color(json["textMainColor"]),
    textSecondaryColor: Color(json["textSecondaryColor"]),
    reversedColor: Color(json["reversedColor"]),
  );

  Map<String, dynamic> toJson() => {
    "isDark": isDark,
    "background": background.value,
    "primaryColor": primaryColor.value,
    "pTint1": pTint1.value,
    "pTint2": pTint2.value,
    "pShade1": pShade1.value,
    "secondary": secondary.value,
    "sTint1": sTint1.value,
    "sTint2": sTint2.value,
    "shade1": shade1.value,
    "cardLight": cardLight.value,
    "lightGrey": lightGrey.value,
    "medGrey": medGrey.value,
    "darkGrey": darkGrey.value,
    "success": success.value,
    "waiting": waiting.value,
    "cancel": cancel.value,
    "informative": informative.value,
    "textMainColor": textMainColor.value,
    "textSecondaryColor": textSecondaryColor.value,
    "reversedColor": reversedColor.value,
  };


  @override
  ThemeModel lerp(ThemeExtension<ThemeModel>? other, double t) {
    if (other is! ThemeModel) {
      return this;
    }
    return SharedPref.getTheme()??defaultTheme;
  }
}