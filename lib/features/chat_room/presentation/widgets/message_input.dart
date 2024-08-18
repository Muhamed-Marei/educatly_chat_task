


import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/show_message/show_failed_message.dart';
import '../../../chat_csreen/presentation/manager/send_message.dart';
import '../../data/models/message_model.dart';
import '../../domain/repositories/chat_room_repo.dart';
import '../manager/message_providr.dart';



class MessageInput extends ConsumerStatefulWidget {
  final String chatRoomId;
  final MessageRepository messageRepository;

  const MessageInput({super.key, required this.chatRoomId, required this.messageRepository});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends ConsumerState<MessageInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      final isTyping = _controller.text.isNotEmpty;
      ref.read(typingStatusProvider.notifier).setTyping(isTyping, widget.chatRoomId, FirebaseAuth.instance.currentUser!.uid);

      // Update the actual message input state
      ref.read(messageInputProvider.notifier).updateMessage(_controller.text);
    });
  }

  @override
  void dispose() {
    ref.read(typingStatusProvider.notifier).setTyping(false, widget.chatRoomId, FirebaseAuth.instance.currentUser!.uid);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageInputState = ref.watch(messageInputProvider);
    _controller.value = _controller.value.copyWith(
      text: messageInputState.message,
      selection: TextSelection.fromPosition(TextPosition(offset: messageInputState.message.length)),
    );

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration.collapsed(hintText: 'Send a message'),
                  focusNode: FocusNode(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: messageInputState.isLoading ? CircularProgressIndicator() : Icon(Icons.send),
                  onPressed: messageInputState.isComposing && !messageInputState.isLoading
                      ? () => _sendMessage(context)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) async {
    final notifier = ref.read(messageInputProvider.notifier);
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null || _controller.text.trim().isEmpty) return;

    final newMessage = MessageModel(
      id: '',
      text: _controller.text.trim(),
      senderId: currentUser.uid,
      timestamp: DateTime.now(),
    );

    final result = await widget.messageRepository.sendMessage(widget.chatRoomId, newMessage);
    result.fold(
          (failure) => showFailedMessage(message: failure.message, context: context),
          (_) => notifier.updateMessage(''),
    );

    // Reset typing status
    ref.read(typingStatusProvider.notifier).setTyping(false, widget.chatRoomId, currentUser.uid);
  }
}
