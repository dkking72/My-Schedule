import '../../../src_exports.dart';
import '../../utils/error_mixin.dart';

class LoginScreen extends StatelessWidget with ErrorHandling {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.put(AuthController());
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: signInFormKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const FadeInImage(
                        placeholder: AssetImage(AssetConst.loader),
                        image: AssetImage(AssetConst.login),
                        height: 300,
                        width: 300,
                      ),
                      // Image.asset(
                      //   AssetConst.login,
                      //   width: 300,
                      //   height: 300,
                      // ),
                      // Image(
                      //   image: const AssetImage(AssetConst.login),
                      //   height: 300,
                      //   width: 300,
                      //   loadingBuilder: (context, child, loadingProgress) {
                      //     if (loadingProgress == null) {
                      //       return child;
                      //     }
                      //     return Center(
                      //       child: CircularProgressIndicator(
                      //         color: Colors.red,
                      //         value: loadingProgress.expectedTotalBytes != null
                      //             ? loadingProgress.cumulativeBytesLoaded /
                      //             loadingProgress.expectedTotalBytes!
                      //             : null,
                      //       ),
                      //     );
                      //   },
                      // ),
                      FadeInUpBig(
                        duration: const Duration(seconds: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextFiledBox(
                              hintText: "Email",
                              maxLines: 1,
                              validator: (value) {
                                if (isEmailValid(value!)) {
                                  return null;
                                } else {
                                  return "Please Enter Valid Email";
                                }
                              },
                              maxLength: 50,
                              expands: false,
                              textInputType: TextInputType.emailAddress,
                              controller: email,
                              filteringTextInputFormatter: [
                                FilteringTextInputFormatter.allow(RegExp("[a-z 0-9]|[.@]")),
                                FilteringTextInputFormatter.deny(" ")
                              ],
                            ),
                            // TextFiledBox(
                            //   hintText: "Email",
                            //   maxLines: 1,
                            //   validator: (value) {
                            //     if (isEmailValid(value!)) {
                            //       return null;
                            //     } else {
                            //       return "Email Invalid";
                            //     }
                            //   },
                            //   maxLength: 50,
                            //   expands: false,
                            //   textInputType: TextInputType.emailAddress,
                            //   controller: email,
                            //   filteringTextInputFormatter:
                            //   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9]|[.@]")),
                            // ),
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
                                  controller: password,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  obscureText: controller.passwordVisible,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(" ", replacementString: "-"),
                                    FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                  ],
                                  maxLength: 30,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Valid Password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    counterText: "",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        !controller.passwordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: AppColors.darkPurple,
                                      ),
                                      onPressed: controller.onVisibilityChanged,
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: AppColors.redColor)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: AppColors.redColor)),
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.FORGET_PASSWORD);
                                    email.clear();
                                    password.clear();
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: AppColors.greyColor),
                                  )),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 60,
                                width: double.maxFinite,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (signInFormKey.currentState!.validate()) {
                                        await controller.login(email: email.text, password: password.text);
                                        password.clear();
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(AppColors.darkPurple),
                                    ),
                                    child: const Text("Sign In")),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Center(
                                child: Text(
                              "Or Continue with...",
                              style: TextStyle(color: AppColors.textColor),
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      await controller.googleSignIn();
                                    },
                                    child: SvgPicture.asset(
                                      AssetConst.googleIcon,
                                      height: 38,
                                    )),
                                const SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                    onTap: () async {
                                      await controller.facebookSignIn();
                                    },
                                    child: SvgPicture.asset(
                                      AssetConst.facebookIcon,
                                      height: 38,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                                onTap: () {
                                  controller.birthdayDateTime = null;
                                  controller.birthdayCtrl.clear();
                                  controller.country = "91";
                                  email.clear();
                                  password.clear();
                                  Get.toNamed(Routes.SING_UP_PAGE);
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't Have An Account?\t",
                                      style: TextStyle(color: AppColors.greyColor),
                                    ),
                                    Text(
                                      "Create Account",
                                      style: TextStyle(color: AppColors.darkGreenColor),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     const SizedBox(
                      //       height: 10,
                      //     ),
                      //     TextFiledBox(
                      //       hintText: "Email",
                      //       maxLines: 1,
                      //       validator: (value) {
                      //         if (isEmailValid(value!)) {
                      //           return null;
                      //         } else {
                      //           return "Email Invalid";
                      //         }
                      //       },
                      //       maxLength: 50,
                      //       expands: false,
                      //       textInputType: TextInputType.emailAddress,
                      //       controller: email,
                      //       filteringTextInputFormatter:
                      //       FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9]|[.@]")),
                      //     ),
                      //     // TextFiledBox(
                      //     //   hintText: "Email",
                      //     //   maxLines: 1,
                      //     //   validator: (value) {
                      //     //     if (isEmailValid(value!)) {
                      //     //       return null;
                      //     //     } else {
                      //     //       return "Email Invalid";
                      //     //     }
                      //     //   },
                      //     //   maxLength: 50,
                      //     //   expands: false,
                      //     //   textInputType: TextInputType.emailAddress,
                      //     //   controller: email,
                      //     //   filteringTextInputFormatter:
                      //     //   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9]|[.@]")),
                      //     // ),
                      //     const SizedBox(
                      //       height: 10,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //           color: AppColors.white,
                      //           borderRadius: BorderRadius.circular(10),
                      //           boxShadow: const [
                      //             BoxShadow(
                      //                 color: Color.fromRGBO(143, 148, 251, 0.3),
                      //                 blurRadius: 20.0,
                      //                 offset: Offset(0, 10))
                      //           ]),
                      //       child: TextFormField(
                      //         controller: password,
                      //         keyboardType: TextInputType.visiblePassword,
                      //         textInputAction: TextInputAction.done,
                      //         obscureText: controller.passwordVisible,
                      //         autovalidateMode: AutovalidateMode.onUserInteraction,
                      //         maxLength: 30,
                      //         validator: (value) {
                      //           if (value == null || value.isEmpty) {
                      //             return 'Please enter Valid password';
                      //           }
                      //           return null;
                      //         },
                      //         decoration: InputDecoration(
                      //           hintText: "Password",
                      //           counterText: "",
                      //           suffixIcon: IconButton(
                      //             icon: Icon(
                      //               !controller.passwordVisible ? Icons.visibility : Icons.visibility_off,
                      //               color: AppColors.darkPurple,
                      //             ),
                      //             onPressed: controller.onVisibilityChanged,
                      //           ),
                      //           hintStyle: const TextStyle(
                      //             color: AppColors.greyColor,
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                      //           focusedBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: const BorderSide(color: Colors.purple, width: 2)),
                      //           errorBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: const BorderSide(color: Colors.red)),
                      //           focusedErrorBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: const BorderSide(color: Colors.red)),
                      //         ),
                      //       ),
                      //     ),
                      //     Align(
                      //       alignment: AlignmentDirectional.centerEnd,
                      //       child: TextButton(
                      //           onPressed: () {
                      //             Get.toNamed(Routes.FORGET_PASSWORD);
                      //           },
                      //           child: const Text(
                      //             "Forgot Password?",
                      //             style: TextStyle(color: AppColors.greyColor),
                      //           )),
                      //     ),
                      //     ClipRRect(
                      //       borderRadius: BorderRadius.circular(10),
                      //       child: SizedBox(
                      //         height: 60,
                      //         width: double.maxFinite,
                      //         child: ElevatedButton(
                      //             onPressed: () async {
                      //               if (signInFormKey.currentState!.validate()) {
                      //                 await controller.login(email: email.text, password: password.text);
                      //               }
                      //             },
                      //             style: ButtonStyle(
                      //               backgroundColor: MaterialStateProperty.all(AppColors.darkPurple),
                      //             ),
                      //             child: const Text("Sign In")),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       height: 25,
                      //     ),
                      //     const Center(
                      //         child: Text(
                      //           "Or Continue with...",
                      //           style: TextStyle(color: AppColors.textColor),
                      //         )),
                      //     const SizedBox(
                      //       height: 20,
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         InkWell(
                      //             onTap: () async {
                      //               await controller.googleSignIn();
                      //             },
                      //             child: SvgPicture.asset(
                      //               AssetConst.googleIcon,
                      //               height: 38,
                      //             )),
                      //         const SizedBox(
                      //           width: 25,
                      //         ),
                      //         InkWell(
                      //             onTap: () async {
                      //               await controller.facebookSignIn();
                      //             },
                      //             child: SvgPicture.asset(
                      //               AssetConst.facebookIcon,
                      //               height: 38,
                      //             )),
                      //       ],
                      //     ),
                      //     const SizedBox(
                      //       height: 25,
                      //     ),
                      //     InkWell(
                      //         onTap: () {
                      //           controller.birthdayDateTime = null;
                      //           controller.birthdayCtrl.clear();
                      //           controller.country = "91";
                      //           Get.toNamed(Routes.SING_UP_PAGE);
                      //         },
                      //         child: const Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               "Don't Have An Account?\t",
                      //               style: TextStyle(color: Colors.grey),
                      //             ),
                      //             Text(
                      //               "Create Account",
                      //               style: TextStyle(color: Colors.green),
                      //             ),
                      //           ],
                      //         )),
                      //   ],
                      // ),
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
