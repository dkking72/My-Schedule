import '../../../src_exports.dart';

class Pages {

  static List<GetPage> pages = [
    // GetPage(name: Routes.ROOT, page: () => const Root()),
    GetPage(
        name: Routes.HOME_PAGE,
        page: () => HomePage(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.LOGIN_PAGE,
        transition: Transition.fade,
        page: () => LoginScreen(),
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.SING_UP_PAGE,
        page: () => SignUpScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.FORGET_PASSWORD,
        page: () => ForgetScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.VERIFICATION,
        page: () => Verification(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.SPLASH_SCREEN,
        page: () => SplashScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.PROFILE_SCREEN,
        page: () => ProfileScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.PHONE_VERIFICATION_SCREEN,
        page: () => PhoneVerification(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.EMAIL_VERIFICATION_SCREEN,
        page: () => EmailVerification(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Routes.EMAIL_VERIFICATION_SCREEN_2,
        page: () => EmailVerification2(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
  ];
}
