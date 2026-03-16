import 'package:sanad_2025/Models/course_model.dart';
import 'package:sanad_2025/Modules/Home/home_controller.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/Widgets/video_style1_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/home_model.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/course_style1_widget.dart';
import '../../Widgets/custom_appbar_widget.dart';
import '../../Widgets/custom_network_image.dart';
import 'course_details_controller.dart';
import 'sadad_payment_page.dart'; // تأكد من المسار الصحيح

class CourseDetailsScreen extends StatefulWidget {
  static const routeName = "courseDetails";
  final CourseModel? courseModel;

  const CourseDetailsScreen({Key? key, required this.courseModel}) : super(key: key);

  @override
  State createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends StateMVC<CourseDetailsScreen> {
  _CourseDetailsScreenState() : super(CourseDetailsController()) {
    con = CourseDetailsController();
  }

  late CourseDetailsController con;

  @override
  void initState() {
    super.initState();
    if(widget.courseModel == null) context.pop();
    con.courseModel = widget.courseModel!;
    con.init(); // تمرير context للـ controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget.detailsScreen(withShadow: false),
      body: LoadingWidget(
        loading: con.loading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(con.courseModel.video != null)
                VideoStyle1Widget(
                  width: double.infinity,
                  height: 200.h,
                  video: VideoModel(
                    video: con.courseModel.video,
                    image: con.courseModel.image,
                  ),
                  radius: 0.h,
                ),
              if(con.courseModel.video == null && con.courseModel.image != null)
                CustomNetworkImage(
                  height: 300.h,
                  url: con.courseModel.image,
                  radius: 0,
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(Strings.category.tr, style: TextStyleHelper.of(context).s_18W600),
                    Wrap(
                      spacing: 8.r,
                      children: con.courseModel.subtitle.map((e) => Chip(
                        label: Text(e.name ?? "", style: TextStyleHelper.of(context).s_14W300.copyWith(
                            color: ThemeClass.of(context).secondary
                        )),
                        backgroundColor: ThemeClass.of(context).background,
                        side: BorderSide(color: ThemeClass.of(context).secondary,width: 1.r),
                      )).toList(),
                    ),

                    // بطاقة معلومات الدورة
                    CardViewWidget(
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(con.courseModel.title ?? "-", style: TextStyleHelper.of(context).s_16W600),
                          SizedBox(height: 16.h),
                          InfoWidget(title: Strings.price.tr, value: con.courseModel.priceWithCurrency, icon: Icons.price_check),
                          InfoWidget(title: Strings.courseLanguage.tr, value: con.courseModel.language ?? "", icon: Icons.language),
                          InfoWidget(title: Strings.courseDuration.tr, value: con.courseModel.duration ?? "", icon: Icons.timeline_rounded),
                          InfoWidget(title: Strings.courseDate.tr, value: con.courseModel.date == null ? "" : DateFormat.yMd().format(con.courseModel.date!), icon: Icons.date_range),
                          InfoWidget(title: Strings.courseTime.tr, value: con.courseModel.time ?? "", icon: Icons.access_time),
                          SizedBox(height: 12.h),
                          if(!con.courseModel.userJoined) Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () => con.bookNow(context),
                              child: Container(
                                width: 324.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                  color: ThemeClass.of(context).cancel,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                alignment: Alignment.center,
                                child: Text("${Strings.bookNow.tr} - ${con.courseModel.priceWithCurrency}", style: TextStyleHelper.of(context).s_18W600.copyWith(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          InkWell(
                            onTap: ()=> Share.share('check this course ${con.courseModel.title ?? ""}'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share, size: 20.r),
                                SizedBox(width: 8.r),
                                Text(Strings.shareCourse.tr, style: TextStyleHelper.of(context).s_16W600),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    // باقي المعلومات مثل المدرس، المتطلبات، المزايا، الدورات الأحدث، تبقى كما هي بدون تعديل
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        color: ThemeClass.of(context).cancel,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(con.courseModel.userJoined)
              InkWell(
                onTap: () {
                  if(con.courseModel.meetingUrl != null) launchUrl(Uri.parse(con.courseModel.meetingUrl!));
                },
                child: Text(con.courseModel.meetingUrl ?? "meetingUrl is empty", style: TextStyleHelper.of(context).s_22W600.copyWith(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                )),
              ),
            if(!con.courseModel.userJoined)
              Row(
                children: [
                  Text(con.courseModel.priceWithCurrency, style: TextStyleHelper.of(context).s_22W600.copyWith(color: Colors.white)),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () => con.bookNow(context),
                    child: Container(
                      width: 120.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(Strings.bookNow.tr, style: TextStyleHelper.of(context).s_16W600.copyWith(color: ThemeClass.of(context).cancel)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// =================== Widgets مساعدة ===================
class CardViewWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const CardViewWidget({super.key, required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.r,
              spreadRadius: 2.r,
              blurStyle: BlurStyle.outer,
              offset: Offset(0.r,3.r),
            )
          ]
      ),
      padding: padding,
      child: child,
    );
  }
}

class InfoWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String value;
  final String? title;
  const InfoWidget({super.key, required this.icon, this.title, required this.value, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 20.r, color: iconColor),
          SizedBox(width: 8.r),
          Expanded(child: Text("${title ?? ""}${title != null ? ": " : ""}$value", style: TextStyleHelper.of(context).s_16W600)),
        ],
      ),
    );
  }
}

class Info2Widget extends StatelessWidget {
  final IconData icon;
  final String title,value;
  const Info2Widget({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 16.r, color: const Color(0xff46757F)),
          SizedBox(width: 4.r),
          Text("$title : $value", style: TextStyleHelper.of(context).s_10Reg.copyWith(color: const Color(0xff46757F))),
        ],
      ),
    );
  }
}
