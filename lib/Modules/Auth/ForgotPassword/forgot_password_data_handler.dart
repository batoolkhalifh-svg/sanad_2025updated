import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';


class ForgotPasswordDataHandler{
  static Future<Either<Failure,String>> forgotPassword({required String email})async{
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(
            url: APIEndPoint.forgotPassword,
          body: {
            'lang': SharedPref.getLanguage(),
            'email': email,
          }
        ),
          fromMap: (map) => map["msg"]
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}