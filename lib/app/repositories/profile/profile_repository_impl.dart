import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poc_login/app/core/exceptions/repository_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/data/remote/dio/dio_client.dart';
import 'package:poc_login/app/models/profile_model.dart';

import '../../data/remote/api/endppoints.dart';
import '../../models/user_model.dart';
import './profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DioClient dioClient;
  ProfileRepositoryImpl({
    required this.dioClient,
  });
  @override
  Future<Either<RepositoryException, List<ProfileModel>>> list() async {
    try {
      final Response(:List data) =
          await dioClient.auth.get(ApiV0EndPoints.profile);
      print('data: $data');
      final profileList = data.map((e) => ProfileModel.fromJson(e)).toList();
      print('profileList: $profileList');
      return Success(profileList);
    } on DioException catch (e, s) {
      log('Erro de DioException em ProfileRepositoryImpl.list',
          name: 'ProfileRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro de DioException em ProfileRepositoryImpl.list'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em ProfileRepositoryImpl.list',
          name: 'ProfileRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, ProfileModel>> me(
      UserModel userModel) async {
    try {
      // final Response(:List data) = await dioClient.auth.get(
      //   ApiV0EndPoints.profile,
      //   queryParameters: {
      //     'user_id': userModel.id,
      //   },
      // );
      // print(data);
      final Response(:data) = await dioClient.auth.get(ApiV0EndPoints.userMe);

      return Success(ProfileModel.fromJson(data['profile']));
    } on DioException catch (e, s) {
      log('Erro em ProfileRepositoryImpl.me DioException',
          name: 'ProfileRepositoryImpl.me DioException',
          error: e,
          stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro em ProfileRepositoryImpl.me DioException'));
    } on ArgumentError catch (e, s) {
      log('Erro em ProfileRepositoryImpl.me ArgumentError',
          name: 'ProfileRepositoryImpl.me ArgumentError',
          error: e,
          stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
