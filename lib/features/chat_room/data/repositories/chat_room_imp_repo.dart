

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/chat_room_repo.dart';
import '../models/message_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class FirestoreMessageRepository implements MessageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<MessageModel>> getMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        DateTime time;

        if (data['timestamp'] is Timestamp) {
          time = (data['timestamp'] as Timestamp).toDate();
        } else {
          time = DateTime.now();
        }

        return MessageModel(
          text: data['text'],
          senderId: data['senderId'],
          timestamp: time, id: doc.id,
        );
      }).toList();
    });
  }
  @override
  Future<Either<Failure, Unit>> sendMessage(String chatRoomId, MessageModel message) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toJson());
      return right(unit);
    } catch (e) {
      return left(Failure.serverError(message: e.toString()));
    }
  }
}
