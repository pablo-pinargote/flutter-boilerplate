import 'package:playground/services/_contracts/third_party_services/responses_contracts/session_response_contract.dart';

class SessionResponse implements SessionResponseContract {
  @override
  String? accessToken;

  SessionResponse(this.accessToken);
}