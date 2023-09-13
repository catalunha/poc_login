import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum NewPasswordStateStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
abstract class NewPasswordState with _$NewPasswordState {
  factory NewPasswordState({
    @Default(NewPasswordStateStatus.initial) NewPasswordStateStatus status,
    String? error,
  }) = _NewPasswordState;
}
