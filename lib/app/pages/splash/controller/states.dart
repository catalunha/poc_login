import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum SplashStateStatus {
  initial,
  login,
  logged,
  error,
}

@freezed
abstract class SplashState with _$SplashState {
  factory SplashState({
    @Default(SplashStateStatus.initial) SplashStateStatus status,
    String? error,
    @Default([]) List<String> msg,
  }) = _SplashState;
}
