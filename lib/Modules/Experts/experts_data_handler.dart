import 'package:dartz/dartz.dart';
import '../../Models/user_model.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class ExpertsDataHandler{
  static Future<Either<Failure,List<UserModel>>> getInstructors()async{
    try {
      List<UserModel> response = await GenericRequest<UserModel>(
        method: RequestApi.get(url: APIEndPoint.instructors),
        fromMap: UserModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}