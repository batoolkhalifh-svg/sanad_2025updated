import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../Models/user_model.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/dio_client.dart';
import '../../../Utilities/api_end_point.dart';

class LoginDataHandler {
  static Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // جلب Device Token وتحويله لـ String لتجنب مشاكل null
      final String deviceToken =
          await FirebaseMessaging.instance.getToken() ?? "";

      // إنشاء RequestApi لتسجيل الدخول
      final request = RequestApi.post(
        url: APIEndPoint.login,
        body: {
          'email': email,
          'password': password,
          'device_token': deviceToken,
        },
      );

      // تمرير request لـ GenericRequest
      final UserModel response = await GenericRequest<UserModel>(
        method: request,
        fromMap: UserModel.fromJson,
      ).getObject();

      // حفظ التوكن
      await DioClient.saveToken(response.token?? "");
      await SharedPref.saveToken(response.token ?? "");

      // حفظ بيانات المستخدم
      await SharedPref.saveCurrentUser(user: response);

      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
