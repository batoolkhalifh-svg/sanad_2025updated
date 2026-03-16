import 'package:sanad_2025/Models/course_model.dart';
import 'package:dartz/dartz.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/error_message_model.dart';

class CourseDetailsDataHandler {
  /// جلب تفاصيل الدورة
  static Future<Either<Failure, CourseModel>> getCourseDetails({required int courseId}) async {
    try {
      CourseModel response = await GenericRequest<CourseModel>(
        method: RequestApi.get(url: APIEndPoint.courseDetails(courseId)),
        fromMap: CourseModel.fromJson,
      ).getObject();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  /// حجز وفتح رابط الدفع
  static Future<Either<Failure, String>> payCourse({required int courseId}) async {
    try {
      final paymentUrl = await GenericRequest<String>(
        method: RequestApi.post(
          url: APIEndPoint.payCourse,
          body: {"course_id": courseId.toString()},
          auth: true,
        ),
        fromMap: (map) {
          // 🟢 استخراج الرابط مباشرة من root
          print("Full API response: $map");
          final paymentUrl = map['payment_url'] as String?;
          print("Payment URL extracted: $paymentUrl");

          if (paymentUrl != null && paymentUrl.isNotEmpty) {
            return paymentUrl;
          }

          // إذا ما وجد شيء
          return "";
        },
      ).getObject();

      if (paymentUrl.isEmpty) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel(
            statusCode: 500,
            statusMessage: "Payment URL not found",
            requestApi: RequestApi.post(
              url: APIEndPoint.payCourse,
              body: {"course_id": courseId.toString()},
              auth: true,
            ),
            responseApi: {},
          ),
        );
      }

      return Right(paymentUrl);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
