import 'package:poc_login/app/core/exceptions/service_exception.dart';

import '../../core/functional_program/either.dart';

abstract interface class UserService {
  Future<Either<ServiceException, Nil>> login(String email, String password);
  Future<bool> hasToken();
  Future<void> logout();
  Future<Either<ServiceException, Nil>> register(String email, String password);
}
