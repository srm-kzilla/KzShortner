import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:kzlinks/utils/load_image.dart';

Future<void> showQRDialog(BuildContext context, String shortCode) async {
  final kzillaUrl = 'https://kzilla.xyz/$shortCode';

  Future _shareQRImage() async {
    final kzlogo = await loadImage(context, "assets/kz_logo.png");

    final image = await QrPainter(
      data: kzillaUrl,
      version: QrVersions.auto,
      gapless: true,
      color: Colors.black,
      embeddedImage: kzlogo,
      emptyColor: Colors.white,
    ).toImageData(200.0); // Generate QR code image data

    final filename = 'qr_code.png';
    final tempDir =
        await getTemporaryDirectory(); // Get temporary directory to store the generated image
    final file = await File('${tempDir.path}/$filename')
        .create(); // Create a file to store the generated image
    var bytes = image!.buffer.asUint8List(); // Get the image bytes
    await file.writeAsBytes(bytes); // Write the image bytes to the file
    final path = await Share.shareFiles([file.path],
        text: 'QR code for ${kzillaUrl} generated with ❤️ by SRMKZILLA',
        subject: 'QR Code',
        mimeTypes: [
          'image/png'
        ]); // Share the generated image using the share_plus package
    //print('QR code shared to: $path');
  }

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 36,
            left: 36,
            right: 36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'QR Code',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: QrImage(
                      data: kzillaUrl,
                      version: QrVersions.auto,
                      embeddedImage: AssetImage("assets/kz_logo.png"),
                      size: 250,
                    ),
                  )),
              const SizedBox(height: 20),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: FilledButton(
                  onPressed: () async {
                    try {
                      _shareQRImage();
                    } catch (e) {
                      debugPrint(e.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Failed to save QR Code!'),
                          backgroundColor: Colors.red.shade600,
                          duration:
                              const Duration(seconds: 2, milliseconds: 500),
                          showCloseIcon: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: const Text('Share QR Code'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
