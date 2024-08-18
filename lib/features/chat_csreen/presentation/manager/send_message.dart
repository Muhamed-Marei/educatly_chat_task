


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageInputState {
  final String message;
  final bool isComposing;
  final bool isLoading;

  MessageInputState({
    required this.message,
    this.isComposing = false,
    this.isLoading = false,
  });

  MessageInputState copyWith({
    String? message,
    bool? isComposing,
    bool? isLoading,
  }) {
    return MessageInputState(
      message: message ?? this.message,
      isComposing: isComposing ?? this.isComposing,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MessageInputNotifier extends StateNotifier<MessageInputState> {
  MessageInputNotifier() : super(MessageInputState(message: ''));

  void updateMessage(String message) {
    state = state.copyWith(
      message: message,
      isComposing: message.trim().isNotEmpty,
    );
  }

  Future<void> sendMessage(String chatRoomId) async {
    if (state.message.trim().isEmpty || state.isLoading) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    state = state.copyWith(isLoading: true);

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'text': state.message.trim(),
        'senderId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Clear message input after successful send
      state = MessageInputState(message: '');
    } catch (e) {
      print('Error sending message: $e');
      // Handle error, e.g., show a snackbar
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final messageInputProvider =
StateNotifierProvider<MessageInputNotifier, MessageInputState>(
      (ref) => MessageInputNotifier(),
);
