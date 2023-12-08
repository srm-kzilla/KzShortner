import 'package:flutter/material.dart';
import 'package:kzlinks/model/link.dart';
import 'package:kzlinks/utils/number_format.dart';

class LinkTile extends StatelessWidget {
  final KzLink link;

  const LinkTile({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Text(
                "kzilla.xyz/${link.shortCode}",
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Copied to clipboard'),
                        backgroundColor: Colors.green.shade600,
                        duration: const Duration(seconds: 2, milliseconds: 500),
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
      horizontalTitleGap: 8,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                formatNumber(link.clicks),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Card(
            margin: EdgeInsets.zero,
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.analytics_rounded),
                        SizedBox(width: 8),
                        Text('Analytics'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.qr_code_rounded),
                        SizedBox(width: 8),
                        Text('QR Code'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyLinksListview extends StatelessWidget {
  final List<KzLink> links;

  const MyLinksListview({super.key, required this.links});

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
        return LinkTile(link: links[index]);
      },
    );
  }
}
