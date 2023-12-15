import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://kzilla.xyz/api/v1/app',
  ),
);
