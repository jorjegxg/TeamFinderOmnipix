import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';

class SecureStorageService {
  // static final SecureStorageService _instance =
  //     SecureStorageService._internal();
  // final storage = const FlutterSecureStorage();

  //SecureStorageService._internal();
  final box = Hive.box<String>(HiveConstants.authBox);

  SecureStorageService();
  // factory SecureStorageService() {
  //   return _instance;
  // }

  Future<void> write({required String key, required String value}) async {
    await box.put(
      key,
      value,
    );
  }

  Future<String?> read({required String key}) async {
    return box.get(key);
  }

  Future<void> delete({required String key}) async {
    await box.delete(key);
  }
}
