import 'dart:async';

import 'package:flutter/material.dart';

typedef Runner = FutureOr<void> Function();

class FlutterInitSDK {
  static Future<void> initialize(Runner runnner) async {
    WidgetsFlutterBinding.ensureInitialized();

    await runnner();
  }
}
