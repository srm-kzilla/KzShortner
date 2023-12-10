import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://web-production-3ba2.up.railway.app/api/v1/app/',
  ),
);
