


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> storeUserData(User user) async {
  await secureStorage.write(key: 'userEmail', value: user.email);
  await secureStorage.write(key: 'userId', value: user.uid);
}

Future<String?> getUserData() async {
  return await secureStorage.read(key: 'userEmail');
}

Future<void> removeUserData() async {
  await secureStorage.delete(key: 'userEmail');
  await secureStorage.delete(key: 'userId');
}

