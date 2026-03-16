import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/bottom_navbar_widget.dart';
import '../../Widgets/custom_appbar_widget.dart';
import '../../Widgets/instructor_widget.dart';
import 'experts_controller.dart';

class ExpertsScreen extends StatefulWidget {
  static const routeName = "experts";

  const ExpertsScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ExpertsScreenState();
}

class _ExpertsScreenState extends StateMVC<ExpertsScreen> {
  _ExpertsScreenState() : super(ExpertsController()) {
    con = ExpertsController();
  }

  late ExpertsController con;

  @override
  void initState() {
    con.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(title: Strings.experts.tr,withShadow: true),
      body: LoadingWidget(
        loading: con.loading,
        child: Stack(
          children: [
            GridView.count(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 100.h,top: 20.h),
              crossAxisCount: 2,
              childAspectRatio: (190.w / 280.h),
              crossAxisSpacing: 30.w,
              mainAxisSpacing: 16.h,
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              children: con.instructors.map((e) => InstructorWidget(instructor: e,)).toList(),
            ),

            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBarWidget(),
            )
          ],
        ),
      ),
    );
  }
}

