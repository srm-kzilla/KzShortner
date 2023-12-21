import 'dart:async';
import 'package:kzlinks/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kzlinks/screens/home_screen.dart';
import 'package:kzlinks/screens/my_links.dart';
import 'package:kzlinks/utils/flutter_init_sdk.dart';

void main() {
  runZonedGuarded(
    () {
      FlutterInitSDK.initialize(run);
    },
    (error, stack) {
      debugPrint('error: $error');
      debugPrint('stack: $stack');
    },
  );
}

void run() async {
  runApp(
    MaterialApp(
      title: 'KzLinks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      routes: {
        //'/splash': (context) => const SplashScreen(),
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/my_links': (context) => const MyLinks(),
      },
    ),
  );
}
