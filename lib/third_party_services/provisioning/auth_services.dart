import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:playground/services/_contracts/third_party_services/auth_services_contract.dart';
import 'package:playground/services/_contracts/third_party_services/responses_contracts/session_response_contract.dart';
import 'package:playground/third_party_services/provisioning/responses/session_response.dart';


@Injectable(as: AuthServicesContract)
class AuthServices implements AuthServicesContract {
  @override
  Future<SessionResponseContract> getSession(String userName, String password) async {
    Uri uri = Uri.http('localhost:5000', 'playground/token');
    final response = await http.post(uri, headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, String>{
        'username': userName,
        'password': password
    }));
    if (response.statusCode != 200) {
      return SessionResponse(null);
    }
    Map<String, dynamic> responseAsJson = json.decode(response.body);
    return SessionResponse(responseAsJson['access_token']);
  }
}