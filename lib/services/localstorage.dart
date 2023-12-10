import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LinkStorageService {
  static final _storage = LocalStorageService();

  static Future<void> deleteLinks() async {
    await _storage.delete('linkIds');
  }

  static Future<List<String>> getLinkIds() async {
    final linkIds = await _storage.read('linkIds');
    if (linkIds == null) {
      return ["OczlQXMGUQnE"];
    } else {
      return linkIds.split(',');
    }
  }

  static Future<void> updateLinks(List<String> linkIds) async {
    await _storage.write(key: 'linkIds', value: linkIds.join(','));
  }
}

class LocalStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
