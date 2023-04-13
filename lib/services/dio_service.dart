import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/components/storage_const.dart';

class DioService {
  Dio dio = Dio();

  Future<dynamic> getService(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(
              responseType: ResponseType.json,
              method: 'GET',
            ))
        .then((response) {
      return response;
    }).catchError((err) {
      if (err is DioError) {
        return err.response!;
      }
    });
  }

  Future<dynamic> postService(Map<String, dynamic> map, String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    var token = GetStorage().read(StorageKey.token);
    if (token != null) {
      dio.options.headers['authorization'] = token;
    }

    // TODO read token from storage
    return await dio
        .post(url,
            data: dio_service.FormData.fromMap(map),
            options: Options(
              responseType: ResponseType.json,
              method: 'POST',
            ))
        .then((response) {
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.data.toString());

      return response;
    }).catchError((err) {
      if (err is DioError) {
        return err.response!;
      }
    });
  }
}
