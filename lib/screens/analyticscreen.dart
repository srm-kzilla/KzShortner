import 'package:flutter/material.dart';
import 'package:kzlinks/components/analyticbox.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticScreen extends StatelessWidget {
  const AnalyticScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(10), // Add padding to the widget
                    child: ScrollableListViewWidget(),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
