



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/chat_screen_repo.dart';

class UserDataSource implements UserRepository {
  @override
  Stream<Either<Failure, List<UserModel>>> getUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) {
      try {
        final users = snapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data());
        }).toList();
        return right(users);
      } catch (e) {
        return left(Failure.serverError(message: e.toString()));
      }
    });
  }
}



