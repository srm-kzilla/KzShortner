import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kzlinks/components/analytic_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kzlinks/model/analytics.dart';
import 'package:kzlinks/services/api_services.dart';

class AnalyticScreen extends StatelessWidget {
  final String analyticCode;
  const AnalyticScreen({required this.analyticCode, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Analytics?>(
      future: KzApi.getAnalytics(analyticCode),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Error state
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          // No data state
          return const Scaffold(
            body: Center(
              child: Text('No analytics data available.'),
            ),
          );
        } else {
          // Data loaded successfully
          Analytics analytics = snapshot.data!;
          return buildAnalyticScreen(analytics);
        }
      },
    );
  }

  Widget buildAnalyticScreen(Analytics analytics) {
    final clicks = '${analytics.clicks}';
    final link = 'https://kzilla.xyz/${analytics.shortCode}';
    final reports = analytics.reports;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Image(
                image: ResizeImage(AssetImage('assets/icon.png'),
                    width: 50, height: 50)),
          ],
        ),
        actions: [
          PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: "https://kzilla.xyz/analytics/${analyticCode}",
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Analytic code copied to clipboard'),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.share, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Share Analytics'),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
        // actions: [
        //   PopupMenuButton(
        //       icon: Container(
        //           height: 50,
        //           width: 100,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(12),
        //               color: Colors.black),
        //           child: const Center(
        //             child: Text(
        //               'All Time',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 17,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           )),
        //       itemBuilder: (context) {
        //         return [
        //           const PopupMenuItem<int>(
        //             value: 0,
        //             child: Text("All Time"),
        //           ),
        //           const PopupMenuItem<int>(
        //             value: 1,
        //             child: Text("Today"),
        //           ),
        //           const PopupMenuItem<int>(
        //             value: 2,
        //             child: Text("Last 3 Days"),
        //           ),
        //           const PopupMenuItem<int>(
        //             value: 3,
        //             child: Text("This Week"),
        //           ),
        //           const PopupMenuItem<int>(
        //             value: 4,
        //             child: Text("This Month"),
        //           ),
        //           const PopupMenuItem<int>(
        //             value: 5,
        //             child: Text("Custom"),
        //           ),
        //         ];
        //       },
        //       onSelected: (value) {}),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Add padding to the widget
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'Analytics',
            style: TextStyle(
              fontSize: 70,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Scrollbar(
              thickness: 5,
              interactive: true,
              radius: const Radius.circular(10),
              child: Column(
                children: [
                  //link Widget
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 65,
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffF5F5F5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              link,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          )),
                    ),
                  ),
                  //Analytics Widget List
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(0, 0, 0, 1)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  'Clicks',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  clicks,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        Report report = reports[index];
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ScrollableListViewWidget(report));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
