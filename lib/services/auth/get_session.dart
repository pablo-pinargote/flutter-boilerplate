import 'package:either_option/either_option.dart';
import 'package:injectable/injectable.dart';
import 'package:playground/services/_results/access_denied.dart';
import 'package:playground/services/_results/failure.dart';
import 'package:playground/services/_contracts/third_party_services/auth_services_contract.dart';
import 'package:playground/services/_contracts/third_party_services/responses_contracts/session_response_contract.dart';
import 'package:playground/services/_models/user.dart';

abstract class GetSessionContract {
  Future<Either<User, Failure>> execute(String userName, String password);
}

@Injectable(as: GetSessionContract)
class GetSession implements GetSessionContract {

  final AuthServicesContract authServices;

  GetSession(this.authServices);

  @override
  Future<Either<User, Failure>> execute(String userName, String password) async {
    SessionResponseContract getSessionResult = await authServices.getSession(userName, password);
    if (getSessionResult.accessToken == null) {
      return Right(AccessDenied());
    }
    return Left(User('Test', 'User', getSessionResult.accessToken));
  }

}