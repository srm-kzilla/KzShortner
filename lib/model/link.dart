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
}
