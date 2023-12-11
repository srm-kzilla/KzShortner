import 'package:dio/dio.dart';
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
  late Future<List<KzLink>> links;

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
        title: const Text('My Links'),
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: () {
            links = KzApi.getLinks();
            setState(() {});
            return links;
          },
          child: FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.error == null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pull down to refresh',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: MyLinksListview(
                        links: snapshot.data!,
                        onRefresh: () {
                          links = KzApi.getLinks();
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                debugPrint((snapshot.error as DioException)
                    .response!
                    .statusCode
                    .toString()!);
                
                if (snapshot.error is DioException && snapshot.error.response!.statusCode == 404) {
                  return const Center(
                    child: Text('No links found!'),
                  );
                }

                return ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const Icon(
                          CupertinoIcons.exclamationmark_triangle_fill,
                          size: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Failed to load links!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // const SizedBox(height: 20),
                        // Text(
                        //   '${snapshot.error}',
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
                      ],
                    ),
                  ],
                );
              } else {
                return ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const Icon(
                          Icons.link_sharp,
                          size: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Trying to get your shortend links...',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    links = KzApi.getLinks();
    super.initState();
  }
}
