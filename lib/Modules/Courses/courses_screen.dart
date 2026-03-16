import 'package:sanad_2025/Models/category_model.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/custom_appbar_widget.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/bottom_navbar_widget.dart';
import '../../Widgets/course_style1_widget.dart';
import 'courses_controller.dart';

class CoursesScreen extends StatefulWidget {
  static const routeName = "courses";

  final bool onlyMyCourses;
  final String? searchText;
  const CoursesScreen({Key? key, required this.onlyMyCourses, this.searchText}) : super(key: key);

  @override
  State createState() => _CoursesScreenState();
}

class _CoursesScreenState extends StateMVC<CoursesScreen> {
  _CoursesScreenState() : super(CoursesController()) {
    con = CoursesController();
  }

  late CoursesController con;

  @override
  void initState() {
    super.initState();
    con.init(onlyMyCourses: widget.onlyMyCourses, searchText: widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.searchText == null
          ? CustomAppBarWidget.detailsScreen(
          title: widget.onlyMyCourses ? Strings.myCourses.tr : Strings.courses.tr,
          withShadow: true)
          : CustomAppBarWidget.homeScreen(searchText: widget.searchText),
      body: LoadingWidget(
        loading: con.loading,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🌟 أزرار نوع الدورة
                if (!widget.onlyMyCourses)
                  SizedBox(
                    height: 50.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      children: con.courseTypes.map((type) {
                        bool isSelected = con.selectedCourseType == type;
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? ThemeClass.of(context).secondary
                                  : Colors.grey[200],
                              foregroundColor: isSelected ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                            ),
                            onPressed: () => con.onCourseTypeChange(type),
                            child: Text(type, style: TextStyleHelper.of(context).s_14W600),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                // 🌟 قائمة التصنيفات
                if (!widget.onlyMyCourses)
                  SizedBox(
                    height: 72.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      itemCount: con.categories.length,
                      itemBuilder: (_, index) {
                        return Center(
                          child: CategoryWidget(
                            categoryModel: con.categories[index],
                            isSelect: con.selectedCategory?.id == con.categories[index].id,
                            onSelect: () => con.onCategoryChange(con.categories[index]),
                          ),
                        );
                      },
                      separatorBuilder: (_, i) => SizedBox(width: 6.w),
                    ),
                  ),

                // 🌟 عرض الدورات
                if (con.courses.isNotEmpty || con.loading)
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 100.h, top: 8.h),
                      crossAxisCount: 2,
                      childAspectRatio: (190.w / 280.h),
                      crossAxisSpacing: 30.w,
                      mainAxisSpacing: 16.h,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      children: con.courses.map((e) => CourseStyle1Widget(courseModel: e)).toList(),
                    ),
                  ),

                if (!con.loading && con.courses.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        Strings.coursesNotFound.tr,
                        style: TextStyleHelper.of(context).s_22W600,
                      ),
                    ),
                  ),
              ],
            ),

            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

// 🌟 عنصر التصنيف
class CategoryWidget extends StatelessWidget {
  final bool isSelect;
  final Function() onSelect;
  final CategoryModel categoryModel;
  const CategoryWidget({super.key, required this.isSelect, required this.onSelect, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isSelect ? ThemeClass.of(context).secondary.withOpacity(0.20) : null,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ThemeClass.of(context).secondary.withOpacity(isSelect ? 0 : 0.30), width: 2.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        child: Text(categoryModel.title ?? "-", style: TextStyleHelper.of(context).s_14W600),
      ),
    );
  }
}
