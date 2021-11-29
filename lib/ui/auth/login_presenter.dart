import 'package:either_option/either_option.dart';
import 'package:injectable/injectable.dart';
import 'package:playground/services/_models/user.dart';
import 'package:playground/services/_results/failure.dart';
import 'package:playground/services/auth/get_session.dart';

abstract class LoginContract {
  void showAccessToken(User user);
  void showFailureType(String type);
}

@injectable
class LoginPresenter {
  LoginContract? _view;

  GetSessionContract? _getSession;
  LoginPresenter(GetSessionContract getSession, @factoryParam LoginContract? view) {
    _getSession = getSession;
    _view = view;
  }

  void validateSession(userName, password) async {
    Either<User, Failure> getSessionResult = await _getSession!.execute(userName, password);
    getSessionResult.fold((user) => {
      _view!.showAccessToken(user)
    }, (failure) => {
      _view!.showFailureType(failure.runtimeType.toString())
    });
  }
}
