//import 'package:http/http.dart' as http;
//
//class HttpManager {
//
//
//}
//
//Future<http.Response> get(url, {Map<String, String> headers}){
//
//  return get(url,headers: headers);
//}

import 'package:dio/dio.dart';

class HttpManager {

  static final Dio dio = Dio();

  static Future request(String url, {String method = 'get',Map<String,dynamic> queryParameters,
  int timeOut}) {

    final options = Options(method: method,receiveTimeout: timeOut);

    return dio.request(
        url,
        queryParameters: queryParameters,
        options: options
    );

  }

}

Future<Response> get(url, {Map<String, String> headers, Map<String,dynamic> queryParameters, int timeout}) {

  return HttpManager.request(url,
      queryParameters: queryParameters,
      method: 'get',
      timeOut: timeout);
}