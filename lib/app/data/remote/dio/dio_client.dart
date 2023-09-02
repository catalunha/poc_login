import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:poc_login/app/data/remote/dio/interceptors/my_auth_interceptor.dart';

final class DioClient extends DioForNative {
  DioClient()
      : super(
          BaseOptions(
            baseUrl: 'http://192.168.10.113:8000',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        MyAuthInterceptor(),
      ],
    );
  }

  DioClient get auth {
    options.extra['authorized_request'] = true;
    return this;
  }

  DioClient get unauth {
    options.extra['authorized_request'] = false;
    return this;
  }
}
