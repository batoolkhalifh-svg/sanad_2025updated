import 'dart:io';

import 'package:sanad_2025/Models/user_model.dart';
import 'package:sanad_2025/Modules/Settings/settings_data_handler.dart';
import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Auth/Login/login_screen.dart';

class SettingsController extends ControllerMVC {
  // singleton
  factory SettingsController() {
    _this ??= SettingsController._();
    return _this!;
  }
  static SettingsController? _this;
  SettingsController._();

  bool loading = false;

  late TextEditingController firstNameController,lastNameController,emailController,mobileController;
      // addressController, ageController,statusController;
  File? localImage;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    // addressController = TextEditingController();
    // ageController = TextEditingController();
    // statusController = TextEditingController();
    mobileController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    // addressController.dispose();
    // ageController.dispose();
    // statusController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> pickImage()async{
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;
    localImage = File(image.path);
    setState(() { });
  }

  Future onSave()async{
    setState(() {loading = true;});
    final result = await SettingsDataHandler.saveUserData(
      userModel: UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        photo: SharedPref.getCurrentUser()?.photo,
      ),
      image: localImage?.path,
    );
    result.fold((l) => ToastHelper.showError(message: l.message), (r) => ToastHelper.showSuccess(message: r));
    setState(() {loading = false;});
  }

  Future init()async{
    setState(() {loading = true;});
    UserModel? currentUser = SharedPref.getCurrentUser();
    firstNameController.text = currentUser?.firstName??"";
    lastNameController.text = currentUser?.lastName??"";
    emailController.text = currentUser?.email??"";
    mobileController.text = currentUser?.mobile??"";
    localImage = null;
    setState(() {loading = false;});
  }

  Future deleteMyAccount(BuildContext context)async {
    setState(() {loading = true;});
    final result = await SettingsDataHandler.deleteMyAccount();
    result.fold(
      (l) => ToastHelper.showError(message: l.message),
      (r) async{
        await SharedPref.logout();
        if(context.mounted) context.pushNamed(LoginScreen.routeName);
      });
    setState(() {loading = false;});
  }
}
