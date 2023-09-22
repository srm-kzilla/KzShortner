import 'package:flutter/material.dart';
import 'package:kzlinks/components/analytic_box.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticScreen extends StatelessWidget {
  const AnalyticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> data = {
      'Operating Systems': ['Windows', 'Mac', 'Linux', 'Android', 'iOS'],
      'Browsers': ['Chrome', 'Firefox', 'Safari', 'Edge', 'Opera'],
      'locations': ['India', 'USA', 'UK', 'Canada', 'Australia'],
    };

    const clicks = '4100';
    const link = 'https://kzilla.xyz/';
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
              icon: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black),
                  child: const Center(
                    child: Text(
                      'My Files',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("All Time"),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Today"),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Last 3 Days"),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("This Week"),
                  ),
                  const PopupMenuItem<int>(
                    value: 4,
                    child: Text("This Month"),
                  ),
                  const PopupMenuItem<int>(
                    value: 5,
                    child: Text("Custom"),
                  ),
                ];
              },
              onSelected: (value) {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Add padding to the widget
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              child: SingleChildScrollView(
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
                            child: const Center(
                              child: Text(
                                link,
                                style: TextStyle(
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
                                color: Colors.black),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Clicks',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    clicks,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    // Expanded(child:
                    // ListView.builder(
                    //   itemCount: 1,
                    //   itemBuilder: (context, index) {
                    //     return const Text('Hello World');
                    //   },
                    // ),),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ScrollableListViewWidget(data.keys.first,data.values.first),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
