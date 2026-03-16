import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../Models/user_model.dart';
import '../Modules/TrainerDetails/trainers_details_screen.dart';

class InstructorWidget extends StatelessWidget {
  final UserModel instructor;

  const InstructorWidget({super.key, required this.instructor});

  String removeHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        TrainerDetailsScreen.routeName,
        extra: instructor,
      ),
      child: Container(
        width: 170.w,
        padding: EdgeInsets.all(12.r),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// صورة المدرب
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/default_profile.png",
                  image: instructor.photo != null ? instructor.photo! : "",
                  fit: BoxFit.cover,
                  width: 80.r,
                  height: 80.r,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 35.r, color: Colors.grey);
                  },
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// اسم المدرب
            Text(
              instructor.instructorName ?? "",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 6.h),



            SizedBox(height: 8.h),

            /// زر التفاصيل
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "عرض التفاصيل",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}