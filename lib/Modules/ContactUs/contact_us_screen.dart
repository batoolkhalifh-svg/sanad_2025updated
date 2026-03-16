import 'package:sanad_2025/Models/settings_model.dart';
import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:sanad_2025/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_appbar_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import 'contact_us_controller.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = "contactUs";

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends StateMVC<ContactUsScreen> {
  _ContactUsScreenState() : super(ContactUsController()) {
    con = ContactUsController();
  }

  late ContactUsController con;

  SettingsModel get settings => SharedPref.getAppSettings();

  String getSafe(String? value, [String defaultVal = ""]) {
    return value ?? defaultVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(
          title: Strings.contactUs.tr, withShadow: true),
      body: LoadingWidget(
        loading: con.loading,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Spacer(),
                  FlutterSocialButton(
                    url: getSafe(settings.whatsapp),
                    image: Assets.imagesWhatsapp,
                  ),
                  FlutterSocialButton(
                    url: getSafe(settings.instagram),
                    image: Assets.imagesInstagram,
                  ),
                  FlutterSocialButton(
                    url: getSafe(settings.twitter),
                    image: Assets.imagesTwitter,
                  ),
                  FlutterSocialButton(
                    url: getSafe(settings.linkedin),
                    image: Assets.imagesLinkedin,
                  ),
                  FlutterSocialButton(
                    url: getSafe(settings.facebook),
                    image: Assets.imagesFacebook,
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Container(
                width: 210.r,
                height: 50.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xffEB2026), Color(0xff761013)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  Strings.contactUs2.tr,
                  style: TextStyleHelper.of(context)
                      .s_18W600
                      .copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ContactUsWidget(
                        icon: Icons.call,
                        content: getSafe(settings.phone, "N/A"),
                      ),
                      SizedBox(height: 32.h),
                      ContactUsWidget(
                        icon: Icons.email,
                        content: getSafe(settings.mail, "example@mail.com"),
                      ),
                      SizedBox(height: 32.h),
                      ContactUsWidget(
                        icon: Icons.language,
                        content: getSafe(settings.name, "Sanad"),
                      ),
                    ],
                  ),
                  Image.asset(
                    Assets.imagesSocialMedia,
                    width: 170.r,
                    height: 170.r,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                Strings.forContact.tr,
                style: TextStyleHelper.of(context)
                    .s_18W600
                    .copyWith(color: Colors.white),
              ),
              CustomTextFieldWidget(
                hint: Strings.fullName.tr,
                prefixIcon: const Icon(Icons.person_outline),
                controller: con.nameController,
              ),
              SizedBox(height: 12.h),
              CustomTextFieldWidget(
                hint: Strings.email.tr,
                prefixIcon: const Icon(Icons.email_outlined),
                controller: con.emailController,
              ),
              SizedBox(height: 12.h),
              CustomTextFieldWidget(
                hint: Strings.yourMessage.tr,
                prefixIcon: const Icon(Icons.message),
                controller: con.messageController,
                height: 120.h,
                expands: true,
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: con.sendMessage,
                  child: Container(
                    width: 114.r,
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xffEB2026), Color(0xff761013)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      Strings.send.tr,
                      style: TextStyleHelper.of(context)
                          .s_18W600
                          .copyWith(color: Colors.white),
                    ),
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

class ContactUsWidget extends StatelessWidget {
  final IconData icon;
  final String content;
  const ContactUsWidget({super.key, required this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 210.w,
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
                color: ThemeClass.of(context).background,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5.r,
                    spreadRadius: 2.r,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0.r, 3.r),
                  )
                ]),
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              content,
              style: TextStyleHelper.of(context).s_16W700,
            ),
          ),
          PositionedDirectional(
            start: -10.w,
            top: -10.h,
            bottom: -10.h,
            child: Container(
              width: 60.r,
              height: 60.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xffffffff), Color(0xff46757F)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 1],
                    tileMode: TileMode.clamp),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 24.r,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlutterSocialButton extends StatelessWidget {
  final String image;
  final String? url;
  const FlutterSocialButton({super.key, required this.image, required this.url});

  @override
  Widget build(BuildContext context) {
    // لو url null أو فارغ => ارجع SizedBox
    if (url == null || url?.isEmpty == true) return const SizedBox();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url!)), // هنا ممكن تستخدم الـ "!" لأن تحققنا من null
        child: Image.asset(
          image,
          width: 35.r,
          height: 35.r,
          color: ThemeClass.of(context).reversedColor,
        ),
      ),
    );
  }
}

