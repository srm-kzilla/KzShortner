import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kzlinks/utils/load_image.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

Future<void> showQRDialog(BuildContext context, String shortCode) async {
  final kzillaUrl = 'https://kzilla.xyz/$shortCode';

  Future<ByteData> shareQRImage() async {
    final kzlogo = await loadImage(context, "kz_logo.jpg");

    final image = await QrPainter(
      data: kzillaUrl,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      color: Colors.black,
      emptyColor: Colors.white,
      gapless: true,
      embeddedImage: kzlogo,
    ).toImageData(1024.0);

    return image!;
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
                  child: QrImageView(
                    data: kzillaUrl,
                    size: 200,
                    version: QrVersions.auto,
                    gapless: true,
                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                    embeddedImage: AssetImage("kz_logo.jpg"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: FilledButton(
                  onPressed: () async {
                    try {
                      final logo = await shareQRImage();
                      if (kIsWeb) {
                        Uint8List uint8list = logo.buffer.asUint8List();
                        Blob blob = Blob([uint8list], 'image/png');
                        String url = Url.createObjectUrlFromBlob(blob);
                        window.open(url, '_blank');
                      } else {
                        await Share.shareXFiles(
                          [
                            XFile(
                              'qr_code.png',
                              bytes: logo.buffer.asUint8List(),
                            )
                          ],
                          text:
                              'QR code for ${kzillaUrl} generated with ❤️ by SRMKZILLA',
                          subject: 'QR Code',
                        );
                      }
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
