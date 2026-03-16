import 'package:sanad_2025/Modules/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Modules/Courses/courses_screen.dart';
import '../Modules/Experts/experts_screen.dart';
import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';
import '../core/Language/locales.dart';
import '../generated/assets.dart';




class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: 100.h,
            color: ThemeClass.of(context).primaryColor,
          ),
        ),
        Positioned(
          left: 12.w,
          right: 12.w,
          bottom: 16.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BottomNavBarItemWidget(model: _BottomNavBarItemModel.trainers),
              _BottomNavBarItemWidget(model: _BottomNavBarItemModel.courses),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Center(
            child: InkWell(
              onTap: ()=> context.pushNamed(HomeScreen.routeName),
              child: Container(
                width: 90.r,
                height: 90.r,
                decoration: BoxDecoration(
                  color: ThemeClass.of(context).primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 75.r,
                  height: 75.r,
                  decoration: BoxDecoration(
                    color: ThemeClass.of(context).primaryColor.withOpacity(0.65),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 60.r,
                    height: 60.r,
                    decoration: BoxDecoration(
                      color: ThemeClass.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 0,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer,
                          offset: Offset(0.r,3.r),
                        )
                      ]
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(Assets.imagesHome,color: Colors.white,width: 25.r,height: 25.r,),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Row(),
      ],
    );
  }
}

class _BottomNavBarItemWidget extends StatelessWidget {
  final _BottomNavBarItemModel model;
  const _BottomNavBarItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> context.pushNamed(model.routeName,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(model.iconPath,width: 30.r,height: 30.r, color: Colors.white),
          SizedBox(height: 4.h,),
          Text(AppLocalizations.of(context)?.translate(model.title)??"",
            style: TextStyleHelper.of(context).s_16Reg.copyWith(height: 1.4,color: Colors.white),),
        ],
      ),
    );
  }
}


class _BottomNavBarItemModel{
  final String iconPath;
  final String title;
  final String routeName;
  _BottomNavBarItemModel({required this.iconPath, required this.title,required this.routeName });

  static _BottomNavBarItemModel courses = _BottomNavBarItemModel(
    title: Strings.courses,
    iconPath: Assets.imagesCources,
    routeName: CoursesScreen.routeName,
  );

  static _BottomNavBarItemModel trainers = _BottomNavBarItemModel(
    title: Strings.trainers,
    iconPath: Assets.imagesTeacher,
    routeName: ExpertsScreen.routeName
  );
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..quadraticBezierTo(size.width*0.5, size.height,0,0)
      ..lineTo(0.0, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

