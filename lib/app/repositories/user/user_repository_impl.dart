import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:poc_login/app/core/exceptions/auth_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/data/remote/dio/dio_client.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DioClient dioClient;
  UserRepositoryImpl({
    required this.dioClient,
  });
  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) =
          await dioClient.unauth.post('/api/v0/token/', data: {
        "username": email,
        "password": password,
      });
      log('Token: ${data['access']}', name: 'Token');
      return Success(data['access']);
    } on DioException catch (e, s) {
      log('Erro em DioException',
          name: 'UserRepositoryImpl.login', error: e, stackTrace: s);
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.unauthorized) {
          return Failure(AuthException(message: 'Email ou Senha inválidos.'));
        }
      }
      return Failure(
          AuthException(message: 'Erro desconhecido ao realizar login'));
    }
  }
}
