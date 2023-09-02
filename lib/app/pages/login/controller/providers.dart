import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginController build() {
    return LoginController();
  }

  void login() async {}
}
