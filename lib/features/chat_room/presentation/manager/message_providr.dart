



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_room_imp_repo.dart';
import '../../domain/repositories/chat_room_repo.dart';
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return FirestoreMessageRepository();
});

final messagesStreamProvider = StreamProvider.family<List<MessageModel>, String>((ref, chatRoomId) {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getMessages(chatRoomId);
});


// StateNotifierProvider for typing status
final typingStatusProvider = StateNotifierProvider<TypingStatusNotifier, bool>((ref) {
  return TypingStatusNotifier();
});

class TypingStatusNotifier extends StateNotifier<bool> {
  TypingStatusNotifier() : super(false);

  void setTyping(bool isTyping, String chatRoomId, String userId) {
    state = isTyping;
    _updateTypingStatusInFirestore(chatRoomId, userId, isTyping);
  }

  Future<void> _updateTypingStatusInFirestore(String chatRoomId, String userId, bool isTyping) async {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .update({
      'typing': {userId: isTyping} // Assumes typing is stored as a map in Firestore
    });
  }
}
