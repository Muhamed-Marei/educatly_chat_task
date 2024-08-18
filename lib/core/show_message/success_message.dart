




import 'package:flashy_flushbar/flashy_flushbar_widget.dart';

import 'package:flutter/material.dart';

showSuccessMessage({required String message ,required BuildContext context}) {
  FlashyFlushbar
    (
    leadingWidget: const Icon(
      Icons.done,
      color: Colors.white,
      size: 24,
    ),
    backgroundColor: Colors.greenAccent,
    messageStyle: const TextStyle(
        color: Colors.white
    ),
    message: message,
    duration: const Duration(seconds: 4),
    isDismissible: false,
  ).show(
  );
}