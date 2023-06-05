import 'package:my_schedule/firebase_options.dart';
import 'src_exports.dart';

Future<void> main() async {
  ///use app.init() or Get.put(AppService());
  Get.put(AppService());
  // try {
  //   final result = await InternetAddress.lookup('example.com');
  //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //     logger.i('connected');
  //   }
  // } on SocketException catch (_) {
  //   logger.i('not connected');
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      fallbackLocale: LocalizationService.fallbackLocale,
      locale: LocalizationService.locale,
      translations: LocalizationService(),
      initialRoute: FirebaseAuth.instance.currentUser == null ? Routes.LOGIN_PAGE : Routes.HOME_PAGE,
      // initialRoute: Routes.SPLASH_SCREEN,
      getPages: Pages.pages,
    );
  }
}


// class Root extends StatelessWidget {
//   const Root({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       await Future.delayed(
//         const Duration(seconds: 2),
//         () {
//           Get.offAndToNamed(Routes.LOGIN_PAGE);
//         },
//       );
//     });
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
