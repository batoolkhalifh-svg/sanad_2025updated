import 'package:dartz/dartz.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class ContactUsDataHandler{
  static Future<Either<Failure,String>> sendMessage({required String name, required String email,
    required String message})async{
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(
          url: APIEndPoint.contactUs,
          body: {
            'name': name,
            'mail': email,
            'message': message
          }
        ),
        fromMap: (map) => map["msg"]??"",
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}