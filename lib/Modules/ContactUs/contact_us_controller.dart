import 'package:sanad_2025/Modules/ContactUs/contact_us_data_handler.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ContactUsController extends ControllerMVC {
  // singleton
  factory ContactUsController() {
    _this ??= ContactUsController._();
    return _this!;
  }
  static ContactUsController? _this;
  ContactUsController._();

  bool loading = false;

  late TextEditingController nameController,emailController,messageController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }


  Future sendMessage()async{
    setState(() {loading = true;});
    final result = await ContactUsDataHandler.sendMessage(name: nameController.text,email: emailController.text,
    message: messageController.text);
    result.fold((l) => ToastHelper.showError(message: l.message), (r) {
      ToastHelper.showSuccess(message: r);
      nameController.clear();
      emailController.clear();
      messageController.clear();
    });
    setState(() {loading = false;});
  }
}
