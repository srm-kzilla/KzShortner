import 'package:flutter/material.dart';
import 'package:kzlinks/model/analytics.dart';

class ScrollableListViewWidget extends StatelessWidget {
  final Report report;
  const ScrollableListViewWidget(this.report, {super.key});

  @override
  Widget build(BuildContext context) {
    final title = report.name;
    final List<ReportData> items = report.data;
    final total = report.total;
    const List<Color> progressColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 2),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: Scrollbar(
              thickness: 5,
              interactive: true,
              radius: const Radius.circular(10),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(items[index].label),
                        Text('${items[index].value}'), // Adjust this line as needed
                      ],
                    ),
                    subtitle: LinearProgressIndicator(
                      value: items[index].value / total,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColors[index % progressColors.length]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
