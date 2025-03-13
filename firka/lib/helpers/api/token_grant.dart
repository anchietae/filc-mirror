/*
  Firka, alternative e-Kréta client.
  Copyright (C) 2025  QwIT Development

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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