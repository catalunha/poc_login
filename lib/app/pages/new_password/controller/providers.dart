import 'package:poc_login/app/core/exceptions/service_exception.dart';
import 'package:poc_login/app/core/functional_program/either.dart';
import 'package:poc_login/app/pages/new_password/controller/states.dart';
import 'package:poc_login/app/services/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/providers.dart';

part 'providers.g.dart';

@riverpod
class NewPasswordController extends _$NewPasswordController {
  @override
  NewPasswordState build() {
    return NewPasswordState();
  }

  Future<void> newpassword(
      {required String email,
      required String number,
      required String password}) async {
    state = state.copyWith(status: NewPasswordStateStatus.loading);
    final result = await ref.read(userServiceProvider).newpassword(
          email: email,
          password: password,
          number: number,
        );
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: NewPasswordStateStatus.error, error: exception.message);
      case Success():
        ref.invalidate(meUserProvider);
        // ref.invalidate(meProfileProvider);
        state = state.copyWith(status: NewPasswordStateStatus.success);
    }
  }
}
