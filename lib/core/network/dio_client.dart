import 'package:dio/dio.dart';
class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://yts.lt/api/v2/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }
}