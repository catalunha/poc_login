import 'package:poc_login/app/core/exceptions/auth_exception.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, Nil>> register(
      String email, String password);
  Future<bool> verifyToken(String token);
  Future<Either<RepositoryException, UserModel>> me();
}
