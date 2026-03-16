import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sanad_2025/Models/user_model.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Utilities/strings.dart';
import 'package:sanad_2025/Widgets/custom_appbar_widget.dart';
import 'package:sanad_2025/Widgets/custom_network_image.dart';

import '../../core/Language/locales.dart';
import 'trainer_details_controller.dart';

class TrainerDetailsScreen extends StatefulWidget {
  static const routeName = "trainerDetails";
  final UserModel? instructor;

  const TrainerDetailsScreen({Key? key, required this.instructor}) : super(key: key);

  @override
  State createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends StateMVC<TrainerDetailsScreen> {
  _TrainerDetailsScreenState() : super(TrainerDetailsController()) {
    con = TrainerDetailsController();
  }

  late TrainerDetailsController con;

  /// تنظيف النص من HTML tags و HTML entities
  String cleanHtmlText(String htmlText) {
    if (htmlText.isEmpty) return "";

    // إزالة كل الـ tags
    String text = htmlText.replaceAll(RegExp(r'<[^>]*>'), '');

    // استبدال بعض الـ HTML entities الشائعة
    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll(RegExp(r'&[^;]+;'), ''); // أي entity غريبة أخرى

    return text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget.detailsScreen(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// زر مشاركة
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  onTap: () => Share.share(
                      'Check this trainer: ${widget.instructor?.instructorName ?? ""}'),
                  child: Container(
                    width: 110.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: ThemeClass.of(context).secondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, size: 22.r),
                        SizedBox(width: 4.w),
                        Text(
                          Strings.share.tr,
                          style: TextStyleHelper.of(context).s_16W600,
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 75.h),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  /// البطاقة الرئيسية
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.r),
                      border: Border.all(color: ThemeClass.of(context).primaryColor),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        SizedBox(height: 50.r),

                        /// الاسم
                        Row(
                          children: [
                            Container(
                              width: 56.r,
                              height: 56.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeClass.of(context)
                                    .secondary
                                    .withOpacity(0.2),
                              ),
                              alignment: Alignment.center,
                              child:
                              Icon(Icons.verified_user_outlined, size: 30.r),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: Text(
                                  "${Strings.instructorName.tr}: ${widget.instructor?.instructorName ?? ""}",
                                  style: TextStyleHelper.of(context).s_16W600,
                                )),
                          ],
                        ),

                        SizedBox(height: 16.r),

                        /// الايميل
                        Row(
                          children: [
                            Container(
                              width: 56.r,
                              height: 56.r,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeClass.of(context)
                                      .secondary
                                      .withOpacity(0.2)),
                              alignment: Alignment.center,
                              child: Icon(Icons.email_outlined, size: 30.r),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: Text(widget.instructor?.email ?? "",
                                    style: TextStyleHelper.of(context).s_16W600)),
                          ],
                        ),

                        SizedBox(height: 16.r),

                        /// رقم الهاتف
                        Row(
                          children: [
                            Container(
                              width: 56.r,
                              height: 56.r,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeClass.of(context)
                                      .secondary
                                      .withOpacity(0.2)),
                              alignment: Alignment.center,
                              child: Icon(Icons.phone, size: 30.r),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: Text(widget.instructor?.mobile ?? "",
                                    style: TextStyleHelper.of(context).s_16W600)),
                          ],
                        ),

                        SizedBox(height: 16.r),

                        /// التفاصيل
                        Row(
                          children: [
                            Container(
                              width: 56.r,
                              height: 56.r,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeClass.of(context)
                                      .secondary
                                      .withOpacity(0.2)),
                              alignment: Alignment.center,
                              child: Icon(Icons.details, size: 30.r),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: Text(
                                  cleanHtmlText(widget.instructor?.detail ?? ""),
                                  style: TextStyleHelper.of(context).s_16W600,
                                )),
                          ],
                        ),
                        SizedBox(height: 16.r),
                      ],
                    ),
                  ),

                  /// صورة المدرب
                  Positioned(
                    top: -50.h,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        height: 85.r,
                        width: 85.r,
                        decoration: BoxDecoration(
                          color: ThemeClass.of(context).background,
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: ThemeClass.of(context).primaryColor),
                        ),
                        padding: EdgeInsets.all(14.r),
                        child: CustomNetworkImage(
                          url: widget.instructor?.photo != null
                              ? widget.instructor!.photo!
                              : "",
                          width: 56.r,
                          height: 56.r,
                          radius: 30.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}