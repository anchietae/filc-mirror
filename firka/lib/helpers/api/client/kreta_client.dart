import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:firka/helpers/api/model/timetable.dart';
import 'package:firka/helpers/db/models/generic_cache_model.dart';
import 'package:isar/isar.dart';

import '../../db/models/token_model.dart';
import '../consts.dart';
import '../model/grade.dart';
import '../model/notice_board.dart';
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
      // "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      "accept": "*/*",
      "user-agent": "eKretaStudent/264745 CFNetwork/1494.0.7 Darwin/23.4.0",
      "authorization": "Bearer $localToken",
      "apiKey": "21ff6c25-d1da-4a68-a811-c881a6057463"
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
    var cache = await isar.genericCacheModels.get(cacheKey as int);

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
      var cache = GenericCacheModel();
      cache.cacheKey = cacheKey;
      cache.cacheData = jsonEncode(resp);

      isar.genericCacheModels.put(cache);
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

  Future<ApiResponse<List<NoticeBoardItem>>> getNoticeBoard() async {
    var (resp, status, ex, cached) = await _cachingGet(CacheId.getNoticeBoard,
        KretaEndpoints.getNoticeBoard(model.iss!));

    var items = List<NoticeBoardItem>.empty(growable: true);
    String? err;
    try {
      List<dynamic> rawItems = resp;
      for (var item in rawItems) {
        items.add(NoticeBoardItem.fromJson(item));
      }
    } catch (ex) {
      err = ex.toString();
    }

    if (ex != null) {
      err = ex.toString();
    }

    return ApiResponse(items, status, err, cached);
  }

  Future<ApiResponse<List<Grade>>> getGrades() async {
    var (resp, status, ex, cached) = await _cachingGet(CacheId.getGrades,
        KretaEndpoints.getGrades(model.iss!));

    var items = List<Grade>.empty(growable: true);
    String? err;
    try {
      List<dynamic> rawItems = resp;
      for (var item in rawItems) {
        items.add(Grade.fromJson(item));
      }
    } catch (ex) {
      err = ex.toString();
    }

    if (ex != null) {
      err = ex.toString();
    }

    return ApiResponse(items, status, err, cached);
  }

  Future<ApiResponse<List<Lesson>>> getTimeTable(DateTime from, DateTime to) async {
    var formatter = DateFormat('yyyy-MM-dd');
    var fromStr = formatter.format(from);
    var toStr = formatter.format(to);
    // TODO: Custom caching for lessons
    var (resp, status) = await _authJson("GET",
        "${KretaEndpoints.getTimeTable(model.iss!)}?"
            "datumTol=$fromStr&datumIg=$toStr");

    var items = List<Lesson>.empty(growable: true);
    String? err;
    try {
      List<dynamic> rawItems = resp;
      for (var item in rawItems) {
        items.add(Lesson.fromJson(item));
      }
    } catch (ex) {
      err = ex.toString();
    }

    return ApiResponse(items, status, err, false);
  }

}