import '../../../src_exports.dart';

import 'en_us.dart';

class LocalizationService extends Translations {
  static Locale? _locale;

  static Locale? get locale => _locale ?? Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  static final List localeList = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
  ];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en_us};
}
