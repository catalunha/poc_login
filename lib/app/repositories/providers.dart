import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/providers.dart';
import 'user/user_repository.dart';
import 'user/user_repository_impl.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(dioClient: ref.read(dioClientProvider));
}
