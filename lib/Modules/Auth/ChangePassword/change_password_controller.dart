import 'package:sanad_2025/Utilities/dialog_helper.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'change_password_data_handler.dart';

class ChangePasswordController extends ControllerMVC {
  // singleton
  factory ChangePasswordController() {
    _this ??= ChangePasswordController._();
    return _this!;
  }
  static ChangePasswordController? _this;
  ChangePasswordController._();

  bool loading = false;
  late TextEditingController oldPasswordController,newPasswordController,confirmPasswordController;

  @override
  void initState() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  Future changePassword(BuildContext context)async{
    setState(() {loading = true;});
    final result = await ChangePasswordDataHandler.changePassword(
      oldPass: oldPasswordController.text,
      newPass: newPasswordController.text,
      confirmPass: confirmPasswordController.text,
    );
    result.fold((l) => DialogsHelper(context: context, message: l.message).errorDialog(), (r) => ToastHelper.showSuccess(message: r));
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    setState(() {loading = false;});
  }
}
