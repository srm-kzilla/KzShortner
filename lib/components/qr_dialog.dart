import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kzlinks/utils/fetcher.dart';
import 'package:share_plus/share_plus.dart';

Future<void> showQRDialog(BuildContext context, String shortCode) async {
  final kzillaUrl = 'https://kzilla.xyz/$shortCode';
  final imageUrl =
      'https://chart.googleapis.com/chart?cht=qr&chs=500x500&chl=$kzillaUrl';

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
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 250,
                    width: 250,
                    placeholder: (context, url) => const Center(
                      child: Text(
                        'Loading QR Code...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
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
                      final response = await dio.get(
                        imageUrl,
                        options: Options(responseType: ResponseType.bytes),
                      );
                      await Share.shareXFiles(
                        [
                          XFile.fromData(
                            response.data as Uint8List,
                            name: 'qr_code_$shortCode.jpeg',
                            mimeType: 'image/jpeg',
                          ),
                        ],
                        text: 'QR Code for $kzillaUrl',
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
