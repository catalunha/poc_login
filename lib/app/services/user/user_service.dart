import 'package:poc_login/app/core/exceptions/repository_exception.dart';
import 'package:poc_login/app/core/exceptions/service_exception.dart';
import 'package:poc_login/app/models/user_model.dart';

import '../../core/functional_program/either.dart';

abstract interface class UserService {
  Future<Either<ServiceException, Nil>> login(String email, String password);
  Future<bool> verifyToken();
  Future<void> logout();
  Future<Either<ServiceException, Nil>> register(String email, String password);
}
