import '../../../src_exports.dart';

final AppService app = AppService.instance;

class AppService extends GetxService {
  static final AppService instance = AppService();

  UserModel user = UserModel();
  String packageName = "Not Available";
  String packageVersion = "0.0.0+0";
  String deviceModel = "Not Available";
  String deviceOs = "Not Available";

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //:TODO Add Firebase init if needed
    Get.put(PrefService());
    await getDeviceInfo();
    await getPackageInfo();
  }

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    packageVersion = "${packageInfo.version}+${packageInfo.buildNumber}";
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    switch (Platform.operatingSystem) {
      case 'android':
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceOs = "${androidInfo.version}";
        break;
      case 'ios':
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.utsname.machine ?? "Unknown";
        deviceOs = "${iosInfo.systemName} (${iosInfo.systemVersion})";
        break;
      default:
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        deviceModel = webBrowserInfo.userAgent ?? "Unknown";
        deviceOs = Platform.operatingSystemVersion;
    }
  }
}
