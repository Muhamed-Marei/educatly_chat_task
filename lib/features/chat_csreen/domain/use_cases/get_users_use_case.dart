


import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/data/models/user_model.dart';
import '../repositories/chat_screen_repo.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Stream<Either<Failure, List<UserModel>>> call() {
    return repository.getUsers();
  }
}
