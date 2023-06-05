import '../../../src_exports.dart';

final PrefService prefs = PrefService.instance;

class PrefService extends GetxService {
  static final PrefService instance = PrefService();

  late final GetStorage storage;

  @override
  Future<void> onInit() async {
    await GetStorage.init();
    storage = GetStorage();
    super.onInit();
  }

  dynamic getValue({required String key}) {
    return storage.read(key);
  }

  Future<void> setValue({required String key, dynamic value}) async {
    await storage.write(key, value);
  }

  Future<void> removeValue(String key) async {
    await storage.remove(key);
  }
}
