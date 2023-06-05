import '../../../src_exports.dart';

class EmailVerification2 extends StatelessWidget {
  EmailVerification2({Key? key}) : super(key: key);

  final String email = Get.arguments[0];
  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController passCtrl = TextEditingController();
    return GetBuilder<ProfileController>(builder: (context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AssetConst.verification2),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Link Sending on this $email",
                    style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Disclaimer:-",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("1. Go To Email Box"),
                  const Text("2. Click on that link from sending My Schedule App"),
                  const Text("3. On the Web-page confirmation about verify then Re-enter Password and Confirm Press"),
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
                              BoxShadow(color: Color.fromRGBO(143, 148, 251, 0.3), blurRadius: 20.0, offset: Offset(0, 10))
                            ]),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passCtrl,
                        textInputAction: TextInputAction.done,
                        obscureText: controller.passwordVisible,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(" ", replacementString: "-"),
                          FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                        ],
                        maxLines: 1,
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
                            return 'Please enter some text or remove spaces';
                          }
                          return value.length < 6 ? 'At Least 6 letter PASSWORD' : null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          counterText: "",
                          labelStyle: const TextStyle(color: AppColors.textColor),
                          hintText: "Password",
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
                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.purple, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.darkPurple)),
                          onPressed: () async {
                            await controller.userEmailVerified(passCtrl.text);
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
