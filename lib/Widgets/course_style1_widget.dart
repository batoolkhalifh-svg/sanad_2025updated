import 'package:sanad_2025/Models/course_model.dart';
import 'package:sanad_2025/Utilities/strings.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/custom_network_image.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../Modules/CourseDetails/course_details_screen.dart';

class CourseStyle1Widget extends StatelessWidget {
  final CourseModel courseModel;
  const CourseStyle1Widget({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    print("Course title: ${courseModel.title}");
    print("Course type: ${courseModel.courseTypeAr}");
    return InkWell(
      onTap: ()=> context.pushNamed(CourseDetailsScreen.routeName,extra: courseModel),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.r,
            )
          ]
        ),
        child: Column(
          children: [
            Stack(
              children: [
                CustomNetworkImage(url: courseModel.image,
                  height: 120.h, fit: BoxFit.cover,),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: Container(
                    color: ThemeClass.of(context).reversedColor.withOpacity(0.5),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(courseModel.duration?.toString()??"",style: TextStyleHelper.of(context).s_16Reg.copyWith(color: ThemeClass.of(context).background),),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courseModel.title ?? "",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      maxLines: 1),
                  Text("مدرب: ${courseModel.instructor?.instructorName ?? ""}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  Text("نوع الدورة: ${courseModel.courseTypeAr ?? ""}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
                ],
              ),
            ),
            const Spacer(flex: 2,),
            const Divider(height: 0,),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Text(courseModel.courseJoined.toString(),style: TextStyleHelper.of(context).s_16Reg,),
                  Icon(Icons.person_outline,size: 16.r,),
                  const Spacer(),

                  Text(courseModel.priceWithCurrency,style: TextStyleHelper.of(context).s_16Reg,),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
