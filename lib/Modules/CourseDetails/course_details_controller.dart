import 'package:flutter/material.dart';
import 'package:sanad_2025/Models/course_model.dart';
import 'package:sanad_2025/Modules/CourseDetails/course_details_data_handler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utilities/toast_helper.dart';
import 'sadad_payment_page.dart';

class CourseDetailsController extends ControllerMVC {
  static CourseDetailsController? _instance;

  factory CourseDetailsController() {
    _instance ??= CourseDetailsController._();
    return _instance!;
  }

  CourseDetailsController._();

  bool loading = false;
  late CourseModel courseModel;

  /// تهيئة بيانات الدورة
  Future<void> init() async {
    if (courseModel.id == null) return;
    setState(() => loading = true);

    final result = await CourseDetailsDataHandler.getCourseDetails(courseId: courseModel.id!);
    result.fold(
          (failure) => ToastHelper.showError(message: failure.message),
          (r) => courseModel = r,
    );

    setState(() => loading = false);
  }

  /// حجز الدورة وفتح صفحة الدفع
  // لا حاجة لصفحة وسيطة بعد الآن
// كل شيء يتم داخل bookNow() مباشرة
  Future<void> bookNow(BuildContext context) async {
    if (courseModel.id == null) return;
    setState(() => loading = true);

    final result = await CourseDetailsDataHandler.payCourse(courseId: courseModel.id!);

    result.fold(
          (failure) {
        ToastHelper.showError(message: failure.message);
      },
          (paymentUrl) async {
        final uri = Uri.parse(paymentUrl);

        if (await canLaunchUrl(uri)) {
          // يفتح الفاتورة مباشرة
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          // التطبيق يبقى في الخلفية، الطالب يقدر يرجع بسهولة
        } else {
          ToastHelper.showError(message: "لا يمكن فتح صفحة الدفع");
        }
      },
    );

    setState(() => loading = false);
  }

}
