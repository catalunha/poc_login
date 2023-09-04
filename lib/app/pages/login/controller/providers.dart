import 'package:poc_login/app/core/exceptions/service_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/repositories/providers.dart';
import 'package:poc_login/app/services/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'states.dart';

part 'providers.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    return LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: LoginStateStatus.loaging);
    final userService = ref.read(userServiceProvider);
    final result = await userService.login(email, password);
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: LoginStateStatus.error, error: exception.message);
      case Success():
        ref.invalidate(meUserProvider);
        ref.invalidate(meProfileProvider);
        state = state.copyWith(status: LoginStateStatus.success);
    }
  }

  Future<void> create(String email, String password) async {
    state = state.copyWith(status: LoginStateStatus.loaging);
    final userService = ref.read(userServiceProvider);
    final result = await userService.register(email, password);
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: LoginStateStatus.error, error: exception.message);
      case Success():
        ref.invalidate(meUserProvider);
        ref.invalidate(meProfileProvider);
        state = state.copyWith(status: LoginStateStatus.success);
    }
  }
}
