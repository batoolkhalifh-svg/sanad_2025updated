import 'package:sanad_2025/Utilities/dialog_helper.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Home/home_screen.dart';
import 'forgot_password_data_handler.dart';

class ForgotPasswordController extends ControllerMVC {
  // singleton
  factory ForgotPasswordController() {
    _this ??= ForgotPasswordController._();
    return _this!;
  }
  static ForgotPasswordController? _this;
  ForgotPasswordController._();

  bool loading = false;
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController(text: "hamadaali2060git@gmail.com");
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  Future forgotPassword(BuildContext context)async{
    setState(() {loading = true;});
    final result = await ForgotPasswordDataHandler.forgotPassword(email: emailController.text);
    result.fold((l) => DialogsHelper(context: context, message: l.message).errorDialog(), (r) => ToastHelper.showSuccess(message: r));
    emailController.clear();
    setState(() {loading = false;});
  }
}
