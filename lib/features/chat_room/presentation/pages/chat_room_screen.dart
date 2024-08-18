import 'package:educayly_chat_app/features/chat_room/presentation/widgets/message_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/repositories/chat_room_imp_repo.dart';
import '../widgets/messages_list.dart';

class ChatRoom extends StatelessWidget {
  final UserModel otherUser;

  const ChatRoom({super.key, required this.otherUser});

  String getChatRoomId(String userId1, String userId2) {
    return userId1.compareTo(userId2) > 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final chatRoomId = getChatRoomId(currentUser.uid, otherUser.uid);

    return Scaffold(
      appBar: AppBar(title: Text(otherUser.displayName ?? "")),
      body: Column(
        children: [
          Expanded(
            child: MessageList(chatRoomId: chatRoomId),
          ),
          MessageInput(
              chatRoomId: chatRoomId,
              messageRepository: FirestoreMessageRepository()),
        ],
      ),
    );
  }
}
