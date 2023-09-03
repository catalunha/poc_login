import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum HomeStateStatus {
  initial,
  loaded,
  error,
}

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState({
    @Default(HomeStateStatus.initial) HomeStateStatus status,
    String? error,
  }) = _HomeState;
}
