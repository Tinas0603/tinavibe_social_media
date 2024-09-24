import 'package:flutter_tinavibe/utils/storage/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final session = GetStorage();

  static dynamic userSession = session.read(StorageKeys.userSession);
}
