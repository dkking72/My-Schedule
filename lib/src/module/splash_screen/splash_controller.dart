import '../../../src_exports.dart';

class SplashController extends BaseController {
  @override
  void onInit() async {
    animationInitilization();
    super.onInit();
  }

  animationInitilization() async {
    await Future.delayed(const Duration(milliseconds: 7000), () {});
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offAllNamed(Routes.LOGIN_PAGE);
      } else {
        Get.offAllNamed(Routes.HOME_PAGE);
      }
    } catch (e) {
      onError(e, () {});
    }
  }
}

// @override
// void initState() {
//   super.initState();
//   _navigateToHome();
// }
//
// _navigateToHome() async {
//   await Future.delayed(Duration(milliseconds: 5000),(){});
//   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
// }
