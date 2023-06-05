import '../../../src_exports.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.bgPink,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 30.0, color: AppColors.textColor),
                  child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText('MY SCHEDULE',
                            speed: const Duration(milliseconds: 200)),
                      ]),
                ),
                Image.asset(AssetConst.splashIcon),
              ],
            ),
          ),
          bottomNavigationBar: Text(
            "Deep Kalathiya",
            style: GoogleFonts.specialElite(),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
