import 'package:flutter_tinavibe/utils/storage/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

class Storage {
  static final GetStorage session = GetStorage();

  // * Read user session
  static dynamic userSession = session.read(StorageKeys.userSession);
}
