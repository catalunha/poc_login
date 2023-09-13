import 'package:flutter/material.dart';
import 'package:poc_login/app/core/exceptions/auth_exception.dart';
import 'package:poc_login/app/core/exceptions/repository_exception.dart';
import 'package:poc_login/app/core/exceptions/service_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/models/user_model.dart';
import 'package:poc_login/app/repositories/user/user_repository.dart';
import 'package:poc_login/app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_config.dart';
import '../../core/navigation_global_key.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  UserRepository userRepository;
  UserServiceImpl({
    required this.userRepository,
  });
  @override
  Future<Either<ServiceException, Nil>> login(
      String email, String password) async {
    final result = await userRepository.login(email, password);
    switch (result) {
      case Failure(exception: AuthException(:final message)):
        return Failure(ServiceException(message: message));
      case Success(value: final token):
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString(apiAccessTokenName, token);
        return Success(Nil());
    }
  }

  @override
  Future<Either<ServiceException, Nil>> register(
      String email, String password) async {
    final result = await userRepository.register(email, password);
    switch (result) {
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
      case Success():
        return login(email, password);
    }
  }

  @override
  Future<bool> verifyToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(apiAccessTokenName);
    if (token == null) {
      return false;
    }
    return await userRepository.verifyToken(token);
  }

  @override
  Future<void> logout() async {
    //Limpar o token
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(NavigationGlobalKey.instance.navigationKey.currentContext!)
        .pushNamedAndRemoveUntil(AppRoute.login.name, (route) => false);
  }

  @override
  Future<Either<ServiceException, Nil>> newpassword({
    required String email,
    required String password,
    required String number,
  }) async {
    final result = await userRepository.newpassword(
      email: email,
      password: password,
      number: number,
    );
    switch (result) {
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
      case Success():
        return login(email, password);
    }
  }
}
