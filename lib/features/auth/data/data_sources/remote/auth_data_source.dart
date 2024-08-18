import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educayly_chat_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/show_message/show_failed_message.dart';
import '../../../../../core/show_message/success_message.dart';

Future googleLogin({required BuildContext context}) async {
  // Store data needed from the context before awaiting.
  final localizations = AppLocalizations.of(context)!;

  UserCredential? userCredential = await signInWithGoogle();

  // If you pass context across awaits, it's safe to assume the context is still valid.
  if (userCredential != null) {
    // Use the stored localizations variable here
    showSuccessMessage(
      message: "${localizations.successLogin} ${userCredential.user!.email!}",
      context: context,
    );
    await checkIfLoginBefore(context: context);
  } else {
    print("userCredential is null");
    showFailedMessage(
      message: localizations.failedToLogin,
      context: context,
    );
  }
}

Future<void> checkIfLoginBefore({required BuildContext context}) async {
  final firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  final userDoc = await firestore.collection('users').doc(user.uid).get();

  if (userDoc.exists) {
    // User already registered, navigate to home page
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  } else {
    UserModel userModel = UserModel(
      uid: user.uid,
      email: user.email ?? "",
      displayName: user.displayName ?? "",
      photoUrl: user.photoURL ?? '',
    );

    try {
      await firestore.collection('users').doc(user.uid).set(userModel.toJson());
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      showFailedMessage(
        message: e.toString(),
        context: context,
      );
    }

    // Then navigate to home page
  }
}

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // If sign in was cancelled, return null
    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    return null;
  }
}
