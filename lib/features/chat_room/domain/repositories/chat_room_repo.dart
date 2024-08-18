

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/message_model.dart';

abstract class MessageRepository {
  Stream<List<MessageModel>> getMessages(String chatRoomId);
  Future<Either<Failure, Unit>> sendMessage(String chatRoomId, MessageModel message);
}

