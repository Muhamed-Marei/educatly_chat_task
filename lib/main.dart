import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_flushbar/flashy_flushbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/data/models/user_model.dart';
import 'features/auth/presentation/pages/auth_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/chat_csreen/presentation/pages/chat_screen.dart';
import 'firebase_options.dart';
import 'l10n/localization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    host: 'firestore.googleapis.com',
    sslEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: MaterialApp(
        title: 'educatly',


        builder: FlashyFlushbarProvider.init(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(ref.watch(languageCodeProvider).languageCode),
        debugShowCheckedModeBanner: false,
        theme: _buildThemeData(context),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme.light(primary: Colors.blue),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Theme.of(context).primaryColor,
        suffixIconColor: Theme.of(context).primaryColor,
        iconColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
