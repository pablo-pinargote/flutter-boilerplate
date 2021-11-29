import 'package:playground/services/_contracts/third_party_services/responses_contracts/session_response_contract.dart';

abstract class AuthServicesContract {
  Future<SessionResponseContract> getSession(String userName, String password);
}