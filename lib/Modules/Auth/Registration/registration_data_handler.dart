import 'package:sanad_2025/Utilities/extensions.dart';
import 'package:dartz/dartz.dart';

import '../../../Models/user_model.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';


class RegistrationDataHandler{
  static Future<Either<Failure,String>> registration({required UserModel userModel,required String password})async{
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(
          url: APIEndPoint.registration,
          body: {
            'lang': SharedPref.getLanguage(),
            'password': password,
            ...userModel.toJson().dynamicMapToString()..removeAllEmpty(),
          },
        ),
          fromMap: (map) => map["msg"]
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}