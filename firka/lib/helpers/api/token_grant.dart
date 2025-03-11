import 'package:dio/dio.dart';
import 'package:firka/helpers/api/resp/token_grant.dart';
import 'consts.dart';

final dio = Dio();

Future<TokenGrantResponse> getAccessToken(String code) async {
  // request to the KretaEndpoints.tokenGrantUrl endpoint

  final headers = const <String, String>{
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    "accept": "*/*",
    "user-agent": "eKretaStudent/264745 CFNetwork/1494.0.7 Darwin/23.4.0",
  };

  final formData = <String, String>{
    "code": code,
    "code_verifier": "DSpuqj_HhDX4wzQIbtn8lr8NLE5wEi1iVLMtMK0jY6c",
    "redirect_uri": "https://mobil.e-kreta.hu/ellenorzo-student/prod/oauthredirect",
    "client_id": Constants.clientId,
    "grant_type": "authorization_code",
  };
  
  try {
    final response = await dio.post(KretaEndpoints.tokenGrantUrl, options: Options(headers: headers), data: formData);

    switch (response.statusCode) {
      case 200:
        return TokenGrantResponse.fromJson(response.data);
      case 401:
        throw Exception("Invalid grant");
      default:
        throw Exception("Failed to get access token, response code: ${response.statusCode}");
    }
  } catch (e) {
    rethrow;
  }

  
}