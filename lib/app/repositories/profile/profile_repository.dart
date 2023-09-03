import 'package:poc_login/app/models/profile_model.dart';
import 'package:poc_login/app/models/user_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';

abstract interface class ProfileRepository {
  Future<Either<RepositoryException, List<ProfileModel>>> list();
  Future<Either<RepositoryException, ProfileModel>> me(UserModel userModel);
}
