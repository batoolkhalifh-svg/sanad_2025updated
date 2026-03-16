import 'package:sanad_2025/Modules/Courses/courses_data_handler.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/category_model.dart';
import '../../Models/course_model.dart';

class CoursesController extends ControllerMVC {
  // Singleton
  factory CoursesController() {
    _this ??= CoursesController._();
    return _this!;
  }
  static CoursesController? _this;
  CoursesController._();

  bool loading = false;

  // القوائم
  List<CategoryModel> categories = [];
  List<CourseModel> courses = [];

  // الاختيارات الحالية
  CategoryModel? selectedCategory;
  String selectedCourseType = "أونلاين"; // القيمة الافتراضية

  // أنواع الدورات
  List<String> courseTypes = ["الكل","أونلاين", "وجاهي", "أونلاين+وجاهي"];

  // دالة لتغيير نوع الدورة
  void onCourseTypeChange(String type) {
    selectedCourseType = type;
    fetchCourses(); // إعادة جلب الدورات حسب النوع الجديد
  }

  // دالة لتغيير الكاتيجوري
  Future onCategoryChange(CategoryModel categoryModel) async {
    selectedCategory = categoryModel;
    setState(() => loading = true);
    await fetchCourses();
    setState(() => loading = false);
  }

  // جلب الدورات حسب الفلاتر الحالية
  Future fetchCourses({String? searchText}) async {
    setState(() => loading = true);

    final result = await CoursesDataHandler.getCourses(
      categoryId: selectedCategory?.id == 0 ? null : selectedCategory?.id,
      searchText: searchText,
    );

    result.fold(
          (l) => ToastHelper.showError(message: l.message),
          (r) {
        if (selectedCourseType == "الكل") {
          courses = r;
        } else if (selectedCourseType == "أونلاين+وجاهي") {
          courses = r.where((course) {
            final type = (course.courseTypeAr ?? '').replaceAll(' ', '').toLowerCase();
            return type.contains('أونلاين') && type.contains('وجاهي');
          }).toList();
        } else {
          courses = r
              .where((course) => course.courseTypeAr == selectedCourseType)
              .toList();
        }
      },
    );

    setState(() => loading = false);
  }


  // جلب الكاتيجوري
  Future getCategories() async {
    final result = await CoursesDataHandler.getCategories();
    result.fold(
          (l) => ToastHelper.showError(message: l.message),
          (r) {
        categories = r;

        // أضف "الكل" كخيار أول
        categories.insert(
          0,
          CategoryModel(id: 0, title: "الكل"), // id = 0 لأن الكل ليس موجود في DB
        );

        // افتراضيًا نحدد الكل
        selectedCategory ??= categories[0];
      },
    );
  }


  // جلب دوراتي الخاصة
  Future getMyCourses() async {
    final result = await CoursesDataHandler.getMyCourses();
    result.fold(
          (l) => ToastHelper.showError(message: l.message),
          (r) => courses = r,
    );
  }

  // التهيئة عند دخول الشاشة
  Future init({required bool onlyMyCourses, String? searchText}) async {
    courses = [];
    setState(() => loading = true);

    await Future.wait([
      if (!onlyMyCourses) getCategories(),
      if (!onlyMyCourses) fetchCourses(searchText: searchText),
      if (onlyMyCourses) getMyCourses(),
    ]);

    setState(() => loading = false);
  }
}
