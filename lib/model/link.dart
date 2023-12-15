class KzLink {
  final String linkId;
  final String shortCode;
  final String analyticsCode;
  final int clicks;
  final String creatorIpAddress;
  final bool enabled;
  final String longUrl;
  final int timestamp;

  KzLink({
    required this.linkId,
    required this.shortCode,
    required this.analyticsCode,
    required this.clicks,
    required this.creatorIpAddress,
    required this.enabled,
    required this.longUrl,
    required this.timestamp,
  });

  factory KzLink.fromJson(Map<String, dynamic> json) {
    return KzLink(
      linkId: json['linkId'],
      shortCode: json['shortCode'],
      analyticsCode: json['analyticsCode'],
      clicks: json['clicks'],
      creatorIpAddress: json['creatorIpAddress'],
      enabled: json['enabled'],
      longUrl: json['longUrl'],
      timestamp: json['timestamp'],
    );
  }

  KzLink copyWith({
    String? linkId,
    String? shortCode,
    String? analyticsCode,
    int? clicks,
    String? creatorIpAddress,
    bool? enabled,
    String? longUrl,
    int? timestamp,
  }) {
    return KzLink(
      linkId: linkId ?? this.linkId,
      shortCode: shortCode ?? this.shortCode,
      analyticsCode: analyticsCode ?? this.analyticsCode,
      clicks: clicks ?? this.clicks,
      creatorIpAddress: creatorIpAddress ?? this.creatorIpAddress,
      enabled: enabled ?? this.enabled,
      longUrl: longUrl ?? this.longUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

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


class KzNewLink {
  final String linkId;
  final String shortCode;
  final String analyticsCode;

  final String longUrl;

  KzNewLink(
      {required this.linkId,
      required this.shortCode,
      required this.analyticsCode,
      required this.longUrl});

  factory KzNewLink.fromJson(Map<String, dynamic> json) {
    return KzNewLink(
        linkId: json['linkId'],
        shortCode: json['shortCode'],
        analyticsCode: json['analyticsCode'],
        longUrl: json['longUrl']);
  }

  KzNewLink copyWith({
    String? linkId,
    String? shortCode,
    String? analyticsCode,
    int? clicks,
    String? creatorIpAddress,
    bool? enabled,
    String? longUrl,
    int? timestamp,
  }) {
    return KzNewLink(
        linkId: linkId ?? this.linkId,
        shortCode: shortCode ?? this.shortCode,
        analyticsCode: analyticsCode ?? this.analyticsCode,
        longUrl: longUrl ?? this.longUrl);
  }
}
