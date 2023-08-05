import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kzlinks/screens/home.dart';
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
      theme: ThemeData.light(useMaterial3: true),
      // darkTheme: ThemeData.dark(useMaterial3: true),
      home: const Home(),
    ),
  );
}
