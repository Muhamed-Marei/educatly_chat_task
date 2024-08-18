
import 'package:flashy_flushbar/flashy_flushbar_widget.dart';

import 'package:flutter/material.dart';

showFailedMessage({required String message ,required BuildContext context}) {
  FlashyFlushbar
    (
    leadingWidget: const Icon(
      Icons.error,
      color: Colors.white,
      size: 24,
    ),
    backgroundColor: Colors.redAccent,
    messageStyle: const TextStyle(
      color: Colors.white
    ),

    message: message,
    duration: const Duration(seconds: 4),
    isDismissible: false,
  ).show(
  );
}