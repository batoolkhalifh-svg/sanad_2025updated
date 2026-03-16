import 'package:sanad_2025/Models/category_model.dart';
import 'package:sanad_2025/Models/course_model.dart';
import 'package:dartz/dartz.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class CoursesDataHandler{
  static Future<Either<Failure,List<CategoryModel>>> getCategories()async{
    try {
      List<CategoryModel> response = await GenericRequest<CategoryModel>(
        method: RequestApi.get(url: APIEndPoint.categories),
        fromMap: CategoryModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  static Future<Either<Failure,List<CourseModel>>> getCourses({
    int? categoryId,
    String? searchText,
    String? courseType, // 🔥 أضفنا نوع الدورة
  }) async {
    try {
      String url;

      if (searchText != null && searchText.isNotEmpty) {
        url = APIEndPoint.coursesSearchable(searchText);
      } else {
        url = APIEndPoint.coursesByCategoryId(categoryId);
      }

      // 🔥 إذا النوع موجود وغير "all"، ضيفه كـ query
      if (courseType != null && courseType != "all") {
        url += url.contains('?') ? '&' : '?';
        url += 'course_type=$courseType';
      }

      List<CourseModel> response = await GenericRequest<CourseModel>(
        method: RequestApi.get(url: url),
        fromMap: CourseModel.fromJson,
      ).getList();

      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


  static Future<Either<Failure,List<CourseModel>>> getMyCourses()async{
    try {
      List<CourseModel> response = await GenericRequest<CourseModel>(
        method: RequestApi.get(url: APIEndPoint.myCourses),
        fromMap: CourseModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}