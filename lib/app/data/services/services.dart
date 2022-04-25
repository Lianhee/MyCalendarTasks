import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycalendar/app/core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init(String username) async {
    _box = GetStorage();
    await _box.write(username + projectKey, []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
