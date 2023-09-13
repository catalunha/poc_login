import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum LoginStateStatus {
  initial,
  loading,
  updated,
  success,
  error,
}

@freezed
abstract class LoginState with _$LoginState {
  factory LoginState({
    @Default(LoginStateStatus.initial) LoginStateStatus status,
    String? error,
  }) = _LoginState;
}
