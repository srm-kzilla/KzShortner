import 'package:kzlinks/model/link.dart';
import "package:kzlinks/utils/fetcher.dart";

class KzApi {
  static Future<List<KzLink>> getLinks() async {
    final res = await dio.get("/links/me");

    if (res.statusCode == 200) {
      final links = res.data['links'] as List;
      return links.map((e) => KzLink.fromJson(e)).toList();
    }
    return [];
  }
}
