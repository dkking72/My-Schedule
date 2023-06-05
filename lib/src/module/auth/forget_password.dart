import 'package:my_schedule/src/utils/error_mixin.dart';

import '../../../src_exports.dart';

class ForgetScreen extends StatelessWidget with ErrorHandling {
  ForgetScreen({super.key});

  final controller = Get.find<AuthController>();
  final GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.headingColor,
                ),
                onPressed: () {
                  Get.back();
                }),
          ),
          backgroundColor: Colors.white,
          body: Form(
            key: forgotPassFormKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const FadeInImage(
                        placeholder: AssetImage(AssetConst.loader),
                        image: AssetImage(AssetConst.forgetPass),
                        height: 300,
                        width: 300,
                      ),
                      TextFiledBox(
                        hintText: "Email",
                        maxLines: 1,
                        maxLength: 50,
                        expands: false,
                        textInputType: TextInputType.name,
                        controller: emailCtrl,
                        filteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp("[a-z 0-9]|[.@+]")),
                          FilteringTextInputFormatter.deny(" "),
                        ],
                        validator: (value) {
                          if (isEmailValid(value!)) {
                            return null;
                          } else {
                            return "Please Enter Valid Email";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 60,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.darkPurple)),
                              onPressed: () async {
                                if (forgotPassFormKey.currentState!.validate()) {
                                  await controller.forgotPassword(email: emailCtrl.text.trim(), context: context);
                                } else {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //         content:
                                  //             Text("Please Enter Valid Value")));
                                }
                              },
                              child: const Text(
                                "Confirm",
                                style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Already Account?\t",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Sign In",
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
