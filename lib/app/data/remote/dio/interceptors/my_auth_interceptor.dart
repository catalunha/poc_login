import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poc_login/app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_config.dart';
import '../../../../core/navigation_global_key.dart';

class MyAuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    headers.remove('Authorization');
    if (extra case {'authorized_request': true}) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString(apiAccessTokenName);
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;
    print('----------------------------');
    print('----------------------------');
    print('PASSEI PELO MyAuthInterceptor onError ');
    print('----------------------------');
    print('----------------------------');
    if (extra case {'authorized_request': true}) {
      if (response != null &&
          (response.statusCode == HttpStatus.forbidden ||
              response.statusCode == HttpStatus.unauthorized)) {
        Navigator.of(NavigationGlobalKey.instance.navigationKey.currentContext!)
            .pushNamedAndRemoveUntil(AppRoute.login.name, (route) => false);
      }
    }
    handler.reject(err);
  }
}
