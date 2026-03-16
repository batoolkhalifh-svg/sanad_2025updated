import 'package:carousel_slider/carousel_slider.dart';
import 'package:sanad_2025/Utilities/strings.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Widgets/custom_appbar_widget.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/bottom_navbar_widget.dart';
import '../../Widgets/course_style1_widget.dart';
import '../../Widgets/video_style1_widget.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  _HomeScreenState() : super(HomeController()) {
    con = HomeController();
  }

  late HomeController con;

  @override
  void initState() {
    con.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget.homeScreen(),
      body: LoadingWidget(
        loading: con.loading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderWidget(
                images: con.homeData.sliders
                    .map((e) => e.image)
                    .whereType<String>()
                    .toList(),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          ?.translate(Strings.investInYourself) ??
                          "",
                      style: TextStyleHelper.of(context).s_18Reg,
                    ),
                    SizedBox(height: 16.h),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (170.w / 80.h),
                      crossAxisSpacing: 20.w,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      children: con.homeData.introductions
                          .map(
                            (e) => Text(
                          e.title ?? "-",
                          style: TextStyleHelper.of(context)
                              .s_14Reg
                              .copyWith(
                              color: ThemeClass.of(context)
                                  .textMainColor
                                  .withOpacity(0.75)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      )
                          .toList(),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      Strings.ads.tr,
                      style: TextStyleHelper.of(context).s_18Reg,
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              SliderWidget(
                images: con.homeData.banners
                    .map((e) => e.image)
                    .whereType<String>()
                    .toList(),
                autoPlay: true,
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.newestCourses.tr,
                      style: TextStyleHelper.of(context).s_18Reg,
                    ),
                    SizedBox(height: 16.h),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (190.w / 280.h),
                      crossAxisSpacing: 30.w,
                      mainAxisSpacing: 16.h,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      children: con.homeData.courses
                          .map(
                            (e) => CourseStyle1Widget(courseModel: e),
                      )
                          .toList(),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      Strings.introVideos.tr,
                      style: TextStyleHelper.of(context).s_18Reg,
                    ),
                    SizedBox(height: 8.h),
                    ...con.homeData.videos
                        .map(
                          (e) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: VideoStyle1Widget(video: e),
                        ),
                      ),
                    )
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}

// ------------------------------------------------------
// SliderWidget متوافق مع carousel_slider 5.x
// ------------------------------------------------------

class SliderWidget extends StatefulWidget {
  final List<String> images;
  final bool autoPlay;

  const SliderWidget({super.key, required this.images, this.autoPlay = false});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images
              .map(
                (e) => Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: ThemeClass.of(context).lightGrey),
                ),
                image: DecorationImage(
                  image: NetworkImage(e),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: widget.autoPlay,
            enlargeCenterPage: false,
            aspectRatio: 428.w / 242.h,
            height: 242.h,
            viewportFraction: 1,
          ),
        ),
        // زر التالي
        if (!widget.autoPlay)
          PositionedDirectional(
            top: 0,
            bottom: 0,
            start: 8.w,
            child: GestureDetector(
              onTap: () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Icon(
                Icons.arrow_circle_right_rounded,
                color: ThemeClass.of(context).lightGrey,
                size: 30.r,
              ),
            ),
          ),
        // زر السابق
        if (!widget.autoPlay)
          PositionedDirectional(
            top: 0,
            bottom: 0,
            end: 8.w,
            child: GestureDetector(
              onTap: () {
                _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Icon(
                Icons.arrow_circle_left_rounded,
                color: ThemeClass.of(context).lightGrey,
                size: 30.r,
              ),
            ),
          ),
      ],
    );
  }
}
