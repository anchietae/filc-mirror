import 'package:dio/dio.dart';
import 'package:isar/isar.dart';

import '../../db/models/token_model.dart';
import '../consts.dart';
import '../model/student.dart';
import '../token_grant.dart';

class KretaClient {
  bool _tokenMutex = false;
  TokenModel model;
  Isar isar;

  KretaClient(this.model, this.isar);


  Future<T> _mutexCallback<T>(Future<T> Function() callback) async {
    while (_tokenMutex) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    _tokenMutex = true;
    try {
      return callback();
    } finally {
      _tokenMutex = false;
    }
  }

  Future<Response> _authReq(String method, String url,
      [Object? data, bool? refreshed]) async {


    var localToken = await _mutexCallback<String>(() async {
      var now = DateTime.now();

      if (now.millisecondsSinceEpoch >= model.expiryDate!.millisecondsSinceEpoch) {
        var extended = await extendToken(model);
        var tokenModel = TokenModel.fromResp(extended);

        await isar.writeTxn(() async {
          await isar.tokenModels.put(tokenModel);
        });

        model = tokenModel;
      }

      return model.accessToken!;
    });

    final headers = <String, String>{
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      "accept": "*/*",
      "user-agent": "eKretaStudent/264745 CFNetwork/1494.0.7 Darwin/23.4.0",
      "authorization": "Bearer $localToken"
    };

    return await dio.get(url, options: Options(
        method: method,
        headers: headers
    ), data: data);
  }

  Future<dynamic> _authJson(String method, String url, [Object? data]) async {
    var resp = await _authReq(method, url, data);

    if (resp.statusCode! >= 400) {
      return Future.error("Unexpected status code for json request, code: "
          "${resp.statusCode!}");
    }

    return resp.data;
  }

  Future<Student> getStudent() async {
    var resp = await _authJson("GET", KretaEndpoints.getStudentUrl(model.iss!));

    return Student.fromJson(resp);
  }

}