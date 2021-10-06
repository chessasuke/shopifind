import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

import 'screens/welcome_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  (!UniversalPlatform.isWindows) ? await Firebase.initializeApp() : null;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appTheme = watch(appThemeProvider);
      return MaterialApp(
        theme: appTheme.getTheme(),
        home: const WelcomeScreen(),
      );
    });
  }
}
