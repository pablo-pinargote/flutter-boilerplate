// @dart=2.9
import 'package:either_option/either_option.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/di.dart';
import 'package:playground/services/_results/failure.dart';
import 'package:playground/services/_models/user.dart';
import 'package:playground/services/auth/get_session.dart';
import 'package:playground/third_party_services/provisioning/auth_services.dart';

void main() {

  configureDependencies();

  test('success with valid credentials', () async {
    Either<User, Failure> result = await GetSession(AuthServices()).execute('anyball', 'abc123');
    expect(result.isLeft, true);
  });

  test('fail with invalid credentials', () async {
    Either<User, Failure> result = await GetSession(AuthServices()).execute('a', 'abc12');
    expect(result.isRight, true);
  });
}
