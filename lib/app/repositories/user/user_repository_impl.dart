import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:poc_login/app/core/exceptions/auth_exception.dart';
import 'package:poc_login/app/core/exceptions/repository_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/data/remote/dio/dio_client.dart';
import 'package:poc_login/app/models/user_model.dart';

import '../../data/remote/api/endppoints.dart';
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
          await dioClient.unauth.post(ApiV0EndPoints.userToken, data: {
        "email": email,
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
      await dioClient.unauth.post(ApiV0EndPoints.userCreate, data: {
        "email": email,
        "password": password,
      });
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro em UserRepositoryImpl.create no DioException',
          name: 'UserRepositoryImpl.create', error: e, stackTrace: s);
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.badRequest) {
          return Failure(RepositoryException(message: 'Usuário já existe.'));
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
          .post(ApiV0EndPoints.userTokenVerify, data: {"token": token});
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
      final Response(:data) = await dioClient.auth.get(ApiV0EndPoints.userMe);

      return Success(UserModel.fromJson(data['user']));
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

  @override
  Future<Either<RepositoryException, Nil>> newpassword(
      {required String email,
      required String password,
      required String number}) async {
    try {
      await dioClient.unauth.post(ApiV0EndPoints.userNewPassword, data: {
        "email": email,
        "password": password,
        "number": number,
      });
      return Success(Nil());
    } on DioException catch (e, s) {
      log(
        "Erro em UserRepositoryImpl.newpassword",
        name: "UserRepositoryImpl.newpassword",
        error: e,
        stackTrace: s,
      );
      return Failure(RepositoryException(
          message: e.message ??
              "Erro desconhecido em UserRepositoryImpl.newpassword"));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> resetpassword(String email) async {
    try {
      await dioClient.unauth.post(ApiV0EndPoints.userResetPassword, data: {
        "email": email,
      });

      return Success(Nil());
    } on DioException catch (e, s) {
      log("Erro em UserRepositoryImpl.resetpassword",
          name: "UserRepositoryImpl.resetpassword", error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.message ??
              'Erro desconhecido em UserRepositoryImpl.resetpassword'));
    }
  }
}
