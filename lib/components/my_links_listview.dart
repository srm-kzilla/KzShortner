import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kzlinks/components/qr_dialog.dart';
import 'package:kzlinks/model/link.dart';
import 'package:kzlinks/screens/analytic_screen.dart';
import 'package:kzlinks/services/api_services.dart';
import 'package:kzlinks/utils/constants.dart';
import 'package:kzlinks/utils/number_format.dart';

class LinkTile extends StatelessWidget {
  final KzLink link;

  final Function refresh;

  const LinkTile({super.key, required this.link, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: SizedBox(
        height: 56,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    "kzilla.xyz/${link.shortCode}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: "https://kzilla.xyz/${link.shortCode}",
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard'),
                          backgroundColor: Colors.green.shade600,
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
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.copy_rounded),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      horizontalTitleGap: 8,
      trailing: SizedBox(
        height: 56,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 56,
                  width: 30,
                  child: Center(
                    child: Text(
                      formatNumber(link.clicks),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 56,
              child: Card(
                margin: EdgeInsets.zero,
                child: PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () async {
                          // show edit link dialog
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              TextEditingController customUrlController =
                                  TextEditingController(text: link.longUrl);

                              Future<void> editLink() async {
                                final url = customUrlController.text.trim();

                                if (url == link.longUrl) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Please enter a different URL'),
                                      backgroundColor: Colors.red.shade600,
                                      duration: const Duration(
                                          seconds: 2, milliseconds: 500),
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    ),
                                  );
                                  return;
                                }

                                if (url.isEmpty || !linkRegex.hasMatch(url)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Please enter a valid URL'),
                                      backgroundColor: Colors.red.shade600,
                                      duration: const Duration(
                                          seconds: 2, milliseconds: 500),
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  await KzApi.updateLink(
                                    link.copyWith(longUrl: url),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Link Updated'),
                                      backgroundColor: Colors.green.shade600,
                                      duration: const Duration(
                                          seconds: 2, milliseconds: 500),
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          const Text('Failed to update link!'),
                                      backgroundColor: Colors.red.shade600,
                                      duration: const Duration(
                                          seconds: 2, milliseconds: 500),
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    ),
                                  );
                                  return;
                                } finally {
                                  refresh();
                                  Navigator.of(context).pop();
                                }
                              }

                              return Dialog(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Edit Link',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        controller: customUrlController,
                                        decoration: const InputDecoration(
                                          labelText: 'Redirect URL',
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.link),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 48,
                                            child: FilledButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Colors.black45,
                                                ),
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: 100,
                                            height: 48,
                                            child: FilledButton(
                                              onPressed: editLink,
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              child: const Text('Save'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AnalyticScreen(
                                analyticCode: link.analyticsCode,
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.analytics_rounded),
                            SizedBox(width: 8),
                            Text('Analytics'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () async => await showQRDialog(
                          context,
                          link.shortCode,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.qr_code_rounded),
                            SizedBox(width: 8),
                            Text('QR Code'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          try {
                            await KzApi.disableOrEnableLink(
                              link.copyWith(enabled: !link.enabled),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${!link.enabled ? "Enabled" : "Disbaled"} link!'),
                                backgroundColor: Colors.green.shade600,
                                duration: const Duration(
                                    seconds: 2, milliseconds: 500),
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
                            refresh();
                          } catch (e) {
                            debugPrint((e as DioException).response!.data!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Failed to ${link.enabled ? "disable" : "enable"} link!'),
                                backgroundColor: Colors.red.shade600,
                                duration: const Duration(
                                    seconds: 2, milliseconds: 500),
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
                        child: Row(
                          children: [
                            Icon(link.enabled
                                ? Icons.toggle_off
                                : Icons.toggle_on),
                            const SizedBox(width: 8),
                            Text(link.enabled ? 'Disable' : 'Enable'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyLinksListview extends StatelessWidget {
  final List<KzLink> links;

  final Function onRefresh;

  const MyLinksListview({
    super.key,
    required this.links,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty) {
      return const Center(
        child: Text('No links found!'),
      );
    }

    return ListView.builder(
      itemCount: links.length,
      itemBuilder: (context, index) {
        return LinkTile(
          link: links[index],
          refresh: onRefresh,
        );
      },
    );
  }
}
