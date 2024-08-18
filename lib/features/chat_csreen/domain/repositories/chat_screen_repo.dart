

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/data/models/user_model.dart';

abstract class UserRepository {
  Stream<Either<Failure, List<UserModel>>> getUsers();
}

