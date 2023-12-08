import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

Future<void> showQRDialog(BuildContext context, String shortCode) async {
  final qrCode = QrCode.fromData(
    data: "https://kzilla.xyz/$shortCode",
    errorCorrectLevel: QrErrorCorrectLevel.H,
  );

  final qrImage = QrImage(qrCode);
  const decoration = PrettyQrDecoration(
    image: PrettyQrDecorationImage(
      image: AssetImage(
        'assets/kz_logo.png',
      ),
    ),
  );

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
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
              PrettyQrView(
                qrImage: qrImage,
                decoration: decoration,
              ),
              const SizedBox(height: 20),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: FilledButton(
                  onPressed: () async {
                    try {
                      final image = await qrImage.toImageAsBytes(
                        size: 2000,
                        decoration: decoration,
                        format: ImageByteFormat.png,
                      );

                      if (image == null) {
                        throw Exception(
                          'Failed to save QR Code!',
                        );
                      }

                      await Share.shareXFiles(
                        [
                          XFile.fromData(
                            image.buffer.asUint8List(),
                            name: 'qr_code.png',
                            mimeType: 'image/png',
                          ),
                        ],
                        text: 'https://kzilla.xyz/$shortCode',
                      );
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
