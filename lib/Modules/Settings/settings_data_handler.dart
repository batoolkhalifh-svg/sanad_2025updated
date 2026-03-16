import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../Models/user_model.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class SettingsDataHandler{
  static Future<Either<Failure,String>> saveUserData({required UserModel userModel, String? image})async{
    try {
      Map response = await GenericRequest<Map>(
        method: RequestApi.post(
            url: APIEndPoint.updateProfile,
          body: userModel.toApiJson(),
          files: image == null? []:[await http.MultipartFile.fromPath("photo",image,filename: basename(image),)]
        ),
          fromMap: (map) => map["msg"]
      ).getResponse();

      SharedPref.saveCurrentUser(user: UserModel.fromJson(response["data"]..["token"] = SharedPref.getCurrentUser()?.token));
      return Right(response["msg"]);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  static Future<Either<Failure,bool>> deleteMyAccount()async{
    try {
      bool response = await GenericRequest<bool>(
        method: RequestApi.post(
          url: APIEndPoint.removeAccount,
          body: {}
        ),
        fromMap: (map) => map["status"] == true,
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}