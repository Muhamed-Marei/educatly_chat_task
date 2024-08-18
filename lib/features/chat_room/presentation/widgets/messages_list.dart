
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../manager/message_providr.dart';
import 'message_bubble.dart';

class MessageList extends ConsumerWidget {
  final String chatRoomId;

  const MessageList({super.key, required this.chatRoomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsyncValue = ref.watch(messagesStreamProvider(chatRoomId));

    return messagesAsyncValue.when(
      data: (messages) {
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe =
                message.senderId == FirebaseAuth.instance.currentUser!.uid;

            return MessageBubble(
              message: message.text ?? "",
              isMe: isMe,
              time: message.timestamp,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

