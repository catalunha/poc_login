import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:poc_login/app/core/exceptions/auth_exception.dart';
import 'package:poc_login/app/core/exceptions/repository_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/data/remote/dio/dio_client.dart';
import 'package:poc_login/app/models/user_model.dart';

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

  @override
  Future<Either<RepositoryException, Nil>> register(
      String email, String password) async {
    try {
      await dioClient.unauth.post('/api/v0/user/register/', data: {
        "username": email,
        "password": password,
      });
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro em UserRepositoryImpl.create no DioException',
          name: 'UserRepositoryImpl.create', error: e, stackTrace: s);
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.unauthorized) {
          return Failure(
              RepositoryException(message: 'Email ou Senha inválidos.'));
        }
      }
      return Failure(
          RepositoryException(message: 'Erro desconhecido ao criar usuario'));
    }
  }

  @override
  Future<bool> verifyToken(String token) async {
    try {
      print('token = $token');
      final resp = await dioClient.unauth
          .post('/api/v0/token/verify/', data: {"token": token});
      print('verifyToken statusCode = ${resp.statusCode}');
      if (resp.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e, s) {
      log('Erro ao verificar token',
          name: 'UserRepositoryImpl.verifyToken', error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await dioClient.auth.get('/api/v0/users/me');
      return Success(UserModel.fromJson(data));
    } on DioException catch (e, s) {
      log('Erro em UserRepositoryImpl.me DioException',
          name: 'UserRepositoryImpl.me DioException', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro em UserRepositoryImpl.me DioException'));
    } on ArgumentError catch (e, s) {
      log('Erro em UserRepositoryImpl.me ArgumentError',
          name: 'UserRepositoryImpl.me ArgumentError', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
