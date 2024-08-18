

import 'package:flashy_flushbar/flashy_flushbar_widget.dart';

import 'package:flutter/material.dart';

showComingSoonMessage({required BuildContext context}) {
  FlashyFlushbar
    (
    leadingWidget: const Icon(
      Icons.error,
      color: Colors.white,
      size: 24,
    ),
    backgroundColor: Colors.blueAccent,
    messageStyle: const TextStyle(
        color: Colors.yellow
    ),
    message: "coming soon",
    duration: const Duration(seconds: 4),
    isDismissible: false,
  ).show(
  );
}