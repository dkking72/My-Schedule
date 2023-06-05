import '../../../src_exports.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback? callback;
  final String message;
  final String description;
  const ErrorView({
    Key? key,
    this.callback,
    required this.message,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetConst.error),
              const Text("May your account Delete or Disable...! Try to contact your provider...!"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: callback,
                child: const Text("Retry"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
