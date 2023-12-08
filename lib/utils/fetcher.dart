import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://kzilla.xyz/api/v1/app',
  ),
);
