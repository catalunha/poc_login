import 'package:poc_login/app/core/exceptions/auth_exception.dart';

import '../../core/functional_program/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
