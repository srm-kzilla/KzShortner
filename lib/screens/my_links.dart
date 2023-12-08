import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzlinks/components/my_links_listview.dart';
import 'package:kzlinks/model/link.dart';
import 'package:kzlinks/services/api_services.dart';

class MyLinks extends StatefulWidget {
  const MyLinks({super.key});

  @override
  State<MyLinks> createState() => _MyLinksState();
}

class _MyLinksState extends State<MyLinks> {
  Future<List<KzLink>> links = KzApi.getLinks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: () {
            links = KzApi.getLinks();
            return links;
          },
          child: FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.error == null) {
                return MyLinksListview(links: snapshot.data!);
              } else if (snapshot.hasError) {
                return ListView(
                  children: [
                    Column(
                      children: [
                        const Icon(
                          CupertinoIcons.exclamationmark_triangle_fill,
                          size: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Failed to load links!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
