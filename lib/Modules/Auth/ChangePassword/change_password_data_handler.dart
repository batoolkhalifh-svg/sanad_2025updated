import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';


class ChangePasswordDataHandler{
  static Future<Either<Failure,String>> changePassword({required String oldPass,required String newPass,
    required String confirmPass})async{
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(
            url: APIEndPoint.changePassword,
          body: {
            'lang': SharedPref.getLanguage(),
            'old_password': oldPass,
            'new_password': newPass,
            'confirm_password': confirmPass
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