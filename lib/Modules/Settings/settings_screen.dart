import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_appbar_widget.dart';
import '../../Widgets/custom_network_image.dart';
import '../../Widgets/custom_textfield_widget.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends StateMVC<SettingsScreen> {
  _SettingsScreenState() : super(SettingsController()) {
    con = SettingsController();
  }

  late SettingsController con;

  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(title: Strings.settings.tr,withShadow: true),
      body: LoadingWidget(
        loading: con.loading,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [

                  if(con.localImage != null) ClipRRect(
                    borderRadius: BorderRadius.circular(48.r),
                    child: Image.file(con.localImage!,
                      width: 48.r,height: 48.r,fit: BoxFit.cover),
                  ),
                  if(con.localImage == null) ClipRRect(
                    borderRadius: BorderRadius.circular(48.r),
                    child: CustomNetworkImage(url: SharedPref.getCurrentUser()?.photo,
                        width: 48.r,height: 48.r,fit: BoxFit.cover),
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(child: Text("${SharedPref.getCurrentUser()?.firstName??""} ${SharedPref.getCurrentUser()?.lastName??""}",style: TextStyleHelper.of(context).s_18W600,)),

                  InkWell(
                    onTap: con.pickImage,
                    child: Container(
                      width: 48.r,
                      height: 48.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ThemeClass.of(context).textSecondaryColor),
                      ),
                      child: Icon(Icons.camera_alt_outlined,color: ThemeClass.of(context).reversedColor,size: 24.r,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h,),

              CustomTextFieldWidget(
                width: 385.w,
                hint: Strings.firstName.tr,
                prefixIcon: const Icon(Icons.person_outline),
                controller: con.firstNameController,
                enableLabel: true,
              ),
              SizedBox(height: 20.h,),
              CustomTextFieldWidget(
                width: 385.w,
                hint: Strings.lastName.tr,
                prefixIcon: const Icon(Icons.person_outline),
                controller: con.lastNameController,
                enableLabel: true,
              ),
              // SizedBox(height: 20.h,),
              // CustomTextFieldWidget(
              //   width: 385.w,
              //   hint: Strings.age.tr,
              //   prefixIcon: const Icon(Icons.numbers),
              //   controller: con.ageController,
              //   enableLabel: true,
              // ),
              SizedBox(height: 20.h,),
              CustomTextFieldWidget(
                width: 385.w,
                hint: Strings.email.tr,
                prefixIcon: const Icon(Icons.alternate_email_outlined),
                controller: con.emailController,
                enableLabel: true,
              ),
              SizedBox(height: 20.h,),
              CustomTextFieldWidget(
                width: 385.w,
                hint: Strings.mobile.tr,
                prefixIcon: const Icon(Icons.call),
                controller: con.mobileController,
                enableLabel: true,
              ),
              // SizedBox(height: 20.h,),
              // CustomTextFieldWidget(
              //   width: 385.w,
              //   hint: Strings.address.tr,
              //   prefixIcon: const Icon(Icons.location_city),
              //   controller: con.addressController,
              //   enableLabel: true,
              // ),
              // SizedBox(height: 20.h,),
              // CustomTextFieldWidget(
              //   width: 385.w,
              //   hint: Strings.mStatus.tr,
              //   prefixIcon: const Icon(Icons.family_restroom),
              //   controller: con.statusController,
              //   enableLabel: true,
              // ),

              SizedBox(height: 20.h,),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: con.onSave,
                  child: Container(
                    width: 120.r,
                    height: 44.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xffEB2026),Color(0xff761013)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(Strings.save.tr,style: TextStyleHelper.of(context).s_18W600.copyWith(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(height: 300.h,),

              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: ()=> con.deleteMyAccount(context),
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xffEB2026),Color(0xff761013)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(Strings.deleteMyAccount.tr,style: TextStyleHelper.of(context).s_18W600.copyWith(color: Colors.white),),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
