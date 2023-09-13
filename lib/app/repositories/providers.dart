import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/repositories/profile/profile_repository.dart';
import 'package:poc_login/app/repositories/profile/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/providers.dart';
import '../models/profile_model.dart';
import '../models/user_model.dart';
import 'user/user_repository.dart';
import 'user/user_repository_impl.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(dioClient: ref.read(dioClientProvider));
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl(dioClient: ref.read(dioClientProvider));
}

@Riverpod(keepAlive: true)
Future<UserModel> meUser(MeUserRef ref) async {
  final result = await ref.read(userRepositoryProvider).me();
  ref.invalidate(meProfileProvider);
  return switch (result) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception
  };
}

@Riverpod(keepAlive: true)
Future<ProfileModel> meProfile(MeProfileRef ref) async {
  final meUser = await ref.watch(meUserProvider.future);
  final result = await ref.read(profileRepositoryProvider).me(meUser);
  return switch (result) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception
  };
}
