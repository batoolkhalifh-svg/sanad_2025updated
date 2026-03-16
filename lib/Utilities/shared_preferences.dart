import 'dart:convert';
import 'package:sanad_2025/Models/settings_model.dart';
import 'package:sanad_2025/Utilities/router_config.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sanad_2025/core/Font/font_provider.dart';
import '../core/Language/app_languages.dart';
import '../core/Theme/theme_model.dart';
import '../Models/user_model.dart';

class SharedPref{

  static SharedPreferences get prefs => GetIt.instance.get<SharedPreferences>();
  static const String _language = "language_code";
  static const String _currentUserKey = "currentUser";
  static const String _themeKey = "theme";
  static const String _fontSizeKey = "fontSize";
  static const String _fontFamilyKey = "fontFamily";
  static const String _settingsKey = "appSettings";
  static const _deviceTokenKey = "device_token";

  static Future<void> saveDeviceToken(String token) async {
    await prefs.setString(_deviceTokenKey, token);
  }

  // قراءة Device Token
  static String? getDeviceToken() {
    return prefs.getString(_deviceTokenKey);
  }


  static UserModel? getCurrentUser(){
    if(prefs.getString(_currentUserKey) == null) return null;
    return UserModel.fromJson(json.decode(prefs.getString(_currentUserKey)!));
  }

  static Future<bool> saveCurrentUser({required UserModel user})async{
    return await prefs.setString(_currentUserKey, json.encode(user.toJson()));
  }

  static SettingsModel getAppSettings(){
    if(prefs.getString(_settingsKey) == null) return SettingsModel();
    return SettingsModel.fromRawJson(prefs.getString(_settingsKey)!);
  }

  static Future<bool> saveAppSettings({required SettingsModel settings})async{
    return await prefs.setString(_settingsKey, settings.toRawJson());
  }





  static bool isLogin()=> prefs.getString(_currentUserKey) != null;

  static Future<void> logout() async=> await prefs.remove(_currentUserKey);

  static ThemeModel? getTheme(){
    if(prefs.getString(_themeKey) == null) return null;
    return ThemeModel.fromJson(json.decode(prefs.getString(_themeKey)!));
  }
  static Future<void> setTheme({required ThemeModel theme})async{
    await prefs.setString(_themeKey,json.encode(theme.toJson()));
  }

  static double? getFontSizeScale(){
    return prefs.getDouble(_fontSizeKey);
  }
  static Future<void> setFontSizeScale({required double fontSizeScale})async{
    await prefs.setDouble(_fontSizeKey,fontSizeScale);
  }


  static Future setFontFamily({required FontFamilyTypes fontFamily}) async=> await prefs.setInt(_fontFamilyKey, fontFamily.index);
  static FontFamilyTypes?  getFontFamily()=> prefs.getInt(_fontFamilyKey) == null?null:FontFamilyTypes.values[prefs.getInt(_fontFamilyKey)!];


  static String getLanguage() => prefs.getString(_language) ?? appLanguage(CURRENT_CONTEXT!).name;
  static String? getSavedLanguage() => prefs.getString(_language);

  static Future<void> setLanguage({required String lang})async => await prefs.setString(_language,lang);

  static const _tokenKey = "token";

  static Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }

  static String? getToken() {
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    await prefs.remove(_tokenKey);
  }

}