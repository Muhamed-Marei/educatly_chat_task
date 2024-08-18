import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/repositories/chat_screen_imp_repo.dart';
import '../../domain/repositories/chat_screen_repo.dart';
import '../../domain/use_cases/get_users_use_case.dart';

class UserNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  final GetUsersUseCase getUsersUseCase;

  UserNotifier(this.getUsersUseCase) : super(const AsyncValue.loading()) {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    getUsersUseCase().listen((result) {
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (users) => state = AsyncValue.data(users),
      );
    });
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<UserModel>>>((ref) {
  final getUsersUseCase = ref.watch(getUsersUseCaseProvider);
  return UserNotifier(getUsersUseCase);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserDataSource();
});

final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUsersUseCase(repository);
});
