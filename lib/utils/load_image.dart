import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

Future<ui.Image> loadImage(BuildContext context, String assetPath) async {
  final ByteData data = await DefaultAssetBundle.of(context).load(assetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}