import 'package:sanad_2025/Models/user_model.dart';
import 'package:sanad_2025/Modules/Auth/Login/login_screen.dart';
import 'package:sanad_2025/Modules/Auth/Registration/registration_data_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/dialog_helper.dart';
import '../../../Utilities/toast_helper.dart';


class RegistrationController extends ControllerMVC {
  // singleton
  factory RegistrationController() {
    _this ??= RegistrationController._();
    return _this!;
  }
  static RegistrationController? _this;
  RegistrationController._();

  bool loading = false;

  late TextEditingController emailController,firstNameController,lastNameController,passwordController,
      confirmPasswordController,mobileController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  Future registration(BuildContext context)async{
    UserModel user = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mobile: mobileController.text,
      email: emailController.text,
    );
    setState(() {loading = true;});
    final result = await RegistrationDataHandler.registration(userModel: user, password: passwordController.text);
    result.fold((l) => DialogsHelper(context: context, message: l.message).errorDialog(), (r){
      ToastHelper.showSuccess(message: r);
      context.pushNamed(LoginScreen.routeName);
    });
    setState(() {loading = false;});
  }
}
