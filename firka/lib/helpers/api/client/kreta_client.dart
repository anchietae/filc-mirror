import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firka/helpers/db/models/cache_model.dart';
import 'package:isar/isar.dart';

import '../../db/models/token_model.dart';
import '../consts.dart';
import '../model/student.dart';
import '../token_grant.dart';

class ApiResponse<T> {
  T? response;
  int statusCode;
  String? err;
  bool cached;

  ApiResponse(
    this.response,
    this.statusCode,
    this.err,
    this.cached,
  );

  @override
  String toString() {
    return "ApiResponse("
        "response: $response, "
        "statusCode: $statusCode, "
        "err: \"$err\", "
        "cached: $cached"
        ")";
  }
}

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
      [Object? data]) async {
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

  Future<(dynamic, int)> _authJson(String method, String url, [Object? data]) async {
    var resp = await _authReq(method, url, data);

    return (resp.data, resp.statusCode!);
  }

  Future<(dynamic, int, Object?, bool)> _cachingGet(CacheId id, String url) async {
    // it would be *ideal* to use xor and left shift here, however
    // binary operations seem to round the number down to
    // 32 bits for some reason???
    var cacheKey = model.studentId! + ((id.index+1) * pow(10, 11));
    var cache = await isar.cacheModels.get(cacheKey as int);

    dynamic resp;
    int statusCode;
    try {
      (resp, statusCode) = await _authJson("GET", url);

      if (statusCode >= 400) {
        if (cache != null) {
          return (jsonDecode(cache.cacheData!), statusCode, null, true);
        }
      }
    } catch (ex) {
      if (cache != null) {
        return (jsonDecode(cache.cacheData!), 0, ex, true);
      } else {
        return (null, 0, ex, false);
      }
    }

    await isar.writeTxn(() async {
      var cache = CacheModel();
      cache.cacheKey = cacheKey;
      cache.cacheData = jsonEncode(resp);

      isar.cacheModels.put(cache);
    });

    return (resp, statusCode, null, false);
  }

  Future<ApiResponse<Student>> getStudent() async {
    var (resp, status, ex, cached) = await _cachingGet(CacheId.getStudent,
        KretaEndpoints.getStudentUrl(model.iss!));

    Student? student;
    String? err;
    try {
      student = Student.fromJson(resp);
    } catch (ex) {
      err = ex.toString();
    }

    if (ex != null) {
      err = ex.toString();
    }

    return ApiResponse(student, status, err, cached);
  }

}