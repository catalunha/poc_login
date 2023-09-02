import 'package:dio/dio.dart';

class MyAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final RequestOptions(:headers, :extra) = options;
    headers.remove('Authorization');
    if (extra case {'authorized_request': true}) {
      headers.addAll({'Authorization': 'Bearer 123'});
    }
    handler.next(options);
    // // TODO: implement onRequest
    // super.onRequest(options, handler);
  }
}
