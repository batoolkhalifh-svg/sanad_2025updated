import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/shared_preferences.dart';
import '../Auth/Login/login_screen.dart';
import '../Home/home_screen.dart';

class SplashController extends ControllerMVC {
  factory SplashController() {
    _this ??= SplashController._();
    return _this!;
  }

  static SplashController? _this;
  SplashController._();

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;

    if (SharedPref.getToken() != null) {
      // عنده Token → Home
      context.go('/home');
    } else {
      // ما عنده Token → Login
      context.goNamed(LoginScreen.routeName);
    }
  }
}
