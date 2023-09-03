import 'package:poc_login/app/repositories/providers.dart';
import 'package:poc_login/app/services/user/user_service.dart';
import 'package:poc_login/app/services/user/user_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
UserService userService(UserServiceRef ref) {
  return UserServiceImpl(userRepository: ref.read(userRepositoryProvider));
}

@riverpod
FutureOr<void> logout(LogoutRef ref) {
  final userService = ref.read(userServiceProvider);
  userService.logout();
}
