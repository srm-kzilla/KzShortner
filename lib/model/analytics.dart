class Analytics {
  final String shortCode;
  final int clicks;
  final List<Report> reports;

  Analytics({
    required this.shortCode,
    required this.clicks,
    required this.reports,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    final List<dynamic> reportsList = json['reports'];

    return Analytics(
      shortCode: json['shortCode'],
      clicks: json['clicks'],
      reports:
          reportsList.map((reportJson) => Report.fromJson(reportJson)).toList(),
    );
  }
}

class Report {
  final String name;
  final List<ReportData> data;
  final int total;

  Report({
    required this.name,
    required this.data,
    required this.total,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];

    return Report(
      name: json['name'],
      data: dataList.map((dataJson) => ReportData.fromJson(dataJson)).toList(),
      total: json['_total'],
    );
  }
}

class ReportData {
  final String label;
  final int value;

  ReportData({
    required this.label,
    required this.value,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      label: json['label'],
      value: json['value'],
    );
  }
}
