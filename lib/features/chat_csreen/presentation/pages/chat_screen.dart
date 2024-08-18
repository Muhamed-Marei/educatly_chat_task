
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../chat_room/presentation/pages/chat_room_screen.dart';
import '../manager/get_users_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: userState.when(
        data: (users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return UserCard(userModel: users[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error: ${error.toString()}')),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel userModel;

  const UserCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(userModel.photoUrl ?? '')),
        title: Text(userModel.displayName ?? ""),
        subtitle: Text(userModel.email ?? ""),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(otherUser: userModel),
          ),
        ),
      ),
    );
  }
}




