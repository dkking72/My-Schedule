import '../../../src_exports.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitSpinningLines(
            color: AppColors.purple,
            size: 50.0,
          ),
          const SizedBox(height: 20,),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 20.0, color: AppColors.textColor),
            child: AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText('LOADING...',
                      speed: const Duration(milliseconds: 200)),
                ]),
          ),
        ],
      )
    );
  }
}
