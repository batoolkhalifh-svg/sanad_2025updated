import 'package:sanad_2025/Models/notification_model.dart';
import 'package:dartz/dartz.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class NotificationsDataHandler{
  static Future<Either<Failure,List<NotificationModel>>> getNotifications()async{
    try {
      List<NotificationModel> response = await GenericRequest<NotificationModel>(
        method: RequestApi.get(url: APIEndPoint.notifications),
        fromMap: NotificationModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}