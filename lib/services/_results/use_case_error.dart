import 'failure.dart';

class UseCaseError extends Failure {
  dynamic reason;
  UseCaseError(this.reason);
  @override
  Map toJson() => {
    'reason':  reason
  };
}