import '../../../src_exports.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({Key? key}) : super(key: key);

  final UserData userModel = Get.arguments[0];

  final controller = Get.find<ProfileController>();
  final TextEditingController codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCtrl = TextEditingController(text: userModel.email);
    final TextEditingController passCtrl = TextEditingController();
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.headingColor,
                ),
                onPressed: () {
                  Get.offAllNamed(Routes.HOME_PAGE);
                }),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(AssetConst.verification2),
                    const SizedBox(
                      height: 10,
                    ),
                    !controller.emailVisible
                        ? Column(
                            children: [
                              const Text("Please Enter Password to Change your email / verify email"),
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(143, 148, 251, 0.3),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passCtrl,
                                    textInputAction: TextInputAction.done,
                                    obscureText: controller.passwordVisible,
                                    maxLines: 1,
                                    maxLength: 10,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(" ", replacementString: "-"),
                                      FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
                                        return 'Please enter some text or remove spaces';
                                      }
                                      return value.length < 6 ? 'At Least 6 letter PASSWORD' : null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      counterText: "",
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          !controller.passwordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: AppColors.darkPurple,
                                        ),
                                        onPressed: () {
                                          controller.onVisibilityChanged();
                                        },
                                      ),
                                      hintStyle: const TextStyle(
                                        color: AppColors.greyColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: AppColors.purple, width: 2)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: AppColors.purple, width: 2)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: Colors.red)),
                                    ),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  await controller.emailVerification(passCtrl.text);
                                },
                                child: const Text("Click here for Change Email or Verify Email"),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(143, 148, 251, 0.3),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                  ),
                                  TextFormField(
                                      maxLines: 1,
                                      maxLength: 50,
                                      expands: false,
                                      controller: emailCtrl,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp("[a-z 0-9]|[.@]")),
                                        FilteringTextInputFormatter.deny(" ")
                                      ],
                                      decoration: InputDecoration(
                                          labelText: "Email",
                                          counterText: "",
                                          labelStyle: const TextStyle(color: AppColors.textColor),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.alertColor, width: 1)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.alertColor, width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.headingColor, width: 2))))
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  // controller.emailVerification(
                                  //     emailCtrl.text, passCtrl.text);
                                  await controller.sendVerification(emailCtrl.text);
                                  controller.update();
                                },
                                child: const Text("Go to Verified"),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
