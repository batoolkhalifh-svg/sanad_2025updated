import 'package:sanad_2025/Utilities/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../core/network/dio_client.dart';
import '../../Home/home_screen.dart';
import 'login_data_handler.dart';

class LoginController extends ControllerMVC {

  // singleton
  factory LoginController() {
    _this ??= LoginController._();
    return _this!;
  }
  static LoginController? _this;
  LoginController._();

  bool loading = false;
  late TextEditingController emailController,passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  Future login(BuildContext context) async {
    setState(() {
      loading = true;
    });

    final result = await LoginDataHandler.login(
      email: emailController.text,
      password: passwordController.text,
    );

    result.fold(
          (l) {
        DialogsHelper(context: context, message: l.message).errorDialog();
      },
          (r) async {
        // r مفروض يحتوي بيانات المستخدم + token
        final token = r.token; // تأكدي من اسم المفتاح حسب الـ API
        if (token != null) {
          await DioClient.saveToken(token); // ← نحفظ التوكن
        }

        context.pushNamed(HomeScreen.routeName); // نروح للشاشة الرئيسية
      },
    );

    setState(() {
      loading = false;
    });
  }

}
