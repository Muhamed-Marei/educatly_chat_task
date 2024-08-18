

import 'package:firebase_auth/firebase_auth.dart';

import '../../data/data_sources/local/flutter_secure_storage.dart';

Future<void> checkFirstSignIn() async {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? storedUser = await secureStorage.read(key: 'userEmail');

  if (user != null && storedUser == null) {
    // First time, navigate to registration screen
    // Navigate to registration screen
  } else {
    // Navigate to home screen
  }
}
