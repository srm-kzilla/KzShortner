import 'package:flutter/material.dart';
import 'package:kzlinks/model/link.dart';
import 'package:kzlinks/services/localstorage.dart';
import "package:kzlinks/utils/fetcher.dart";

class KzApi {
  static Future<KzLink> disableOrEnableLink(KzLink link) async {
    final res = await dio.put("/", data: {
      "linkId": link.linkId,
      "enabled": link.enabled,
    });

    debugPrint("res: ${res.data}");

    if (res.statusCode != 200) {
      throw Exception("Failed to disable link");
    }

    return KzLink.fromJson(res.data);
  }

  static Future<List<KzLink>> getLinks() async {
    final linkIds = await LinkStorageService.getLinkIds();

    debugPrint("linkIds: $linkIds");

    final res = await dio.get("/me", data: {
      linkIds,
    });

    debugPrint("res: ${res.data}");

    if (res.statusCode == 200) {
      final links = res.data['links'] as List;
      return links.map((e) => KzLink.fromJson(e)).toList();
    }
    return [];
  }

  static Future<KzLink> updateLink(KzLink link) async {
    final res = await dio.put("/", data: {
      "linkId": link.linkId,
      "longUrl": link.longUrl,
    });

    debugPrint("res: ${res.data}");

    if (res.statusCode != 200) {
      throw Exception("Failed to update link");
    }

    return KzLink.fromJson(res.data);
  }
}
