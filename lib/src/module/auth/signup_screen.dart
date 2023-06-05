import 'package:my_schedule/src/utils/error_mixin.dart';

import '../../../src_exports.dart';

class SignUpScreen extends StatelessWidget with ErrorHandling {
  SignUpScreen({super.key});

  final controller = Get.put(AuthController());
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController fNameCtrl = TextEditingController();
  final TextEditingController lNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Scaffold(
          backgroundColor: Colors.white,
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
          body: Form(
            key: signUpFormKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 0),
                        child: const FadeInImage(
                          placeholder: AssetImage(AssetConst.loader),
                          image: AssetImage(AssetConst.signUp),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 1000),
                        child: TextFiledBox(
                          hintText: "First Name",
                          maxLines: 1,
                          maxLength: 20,
                          expands: false,
                          textInputType: TextInputType.name,
                          controller: fNameCtrl,
                          filteringTextInputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                            FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                          ],
                          validator: (String? value) {
                            if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
                              return 'Please enter some text or remove spaces';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 1200),
                        child: TextFiledBox(
                          hintText: "Last Name",
                          maxLines: 1,
                          maxLength: 20,
                          expands: false,
                          textInputType: TextInputType.name,
                          controller: lNameCtrl,
                          filteringTextInputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                            FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                          ],
                          validator: (String? value) {
                            if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
                              return 'Please enter some text or remove spaces';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 1400),
                        child: Stack(
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
                                onTap: () async {
                                  await controller.onDate();
                                },
                                readOnly: true,
                                enabled: true,
                                maxLength: 23,
                                style: const TextStyle(color: AppColors.black),
                                controller: controller.birthdayCtrl,
                                validator: (value) {
                                  if (controller.birthdayDateTime == null) {
                                    return "Please Select Birthday";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Birthday",
                                  hintStyle: const TextStyle(color: AppColors.greyColor),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColors.redColor)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColors.redColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 1600),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.countryCode();
                              },
                              child: Container(
                                  width: 50,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 1, color: AppColors.greyColor),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(143, 148, 251, 0.3),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Center(
                                      child: Text(
                                    "+${controller.country}",
                                    textAlign: TextAlign.center,
                                  ))),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Stack(
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
                                    keyboardType: TextInputType.phone,
                                    controller: phoneCtrl,
                                    maxLines: 1,
                                    maxLength: 15,
                                    validator: (value) {
                                      // logger.i(controller.country.length + value!.length);
                                      // String a = controller.country;
                                      // String pattern = '/^$a(?:\W*\d){0,13}\d$/gm';
                                      // RegExp regExp = RegExp(pattern);
                                      // if (value.isEmpty) {
                                      //   return 'Please enter mobile number';
                                      // }
                                      // else if (!regExp.hasMatch(value)) {
                                      //   return 'Please enter valid mobile number';
                                      // }
                                      // return null;
                                      return (controller.country.length + value!.length) < 11
                                          ? 'Check Phone Number with country code'
                                          : null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Phone",
                                      hintStyle: const TextStyle(
                                        color: AppColors.greyColor,
                                      ),
                                      counterText: "",
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 1800),
                        child: TextFiledBox(
                          hintText: "Email",
                          maxLines: 1,
                          maxLength: 50,
                          expands: false,
                          textInputType: TextInputType.emailAddress,
                          controller: emailCtrl,
                          filteringTextInputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp("[a-z 0-9]|[.@]")),
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          validator: (String? value) {
                            if (isEmailValid(value!)) {
                              return null;
                            } else {
                              return "Please Enter Valid Email";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2000),
                        child: Stack(
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
                              controller: passWordCtrl,
                              textInputAction: TextInputAction.done,
                              obscureText: controller.passwordVisible,
                              maxLines: 1,
                              maxLength: 30,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(" ", replacementString: "-"),
                                FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password to secure account';
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2200),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 60,
                            width: double.maxFinite,
                            child: ElevatedButton(
                                style:
                                    const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.darkPurple)),
                                onPressed: () async {
                                  if (signUpFormKey.currentState!.validate()) {
                                    final d = UserData(
                                        fName: fNameCtrl.text,
                                        lName: lNameCtrl.text,
                                        email: emailCtrl.text,
                                        phone: phoneCtrl.text,
                                        password: passWordCtrl.text,
                                        phoneVerified: false,
                                        emailVerified: false,
                                        // birthday: controller.birthdayDateTime
                                        countryCode: '+${controller.country}',
                                        birthday: controller.birthdayDateTime!);
                                    await controller.signUp(userData: d);
                                  } else {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //     content:
                                    //         Text('Please Insert Valid value'),
                                    //   ),
                                    // );
                                  }
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2400),
                        child: const Center(
                            child: Text(
                          "Or Continue with...",
                          style: TextStyle(color: AppColors.textColor),
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2600),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () async {
                                  await controller.googleSignIn();
                                },
                                child: SvgPicture.asset(AssetConst.googleIcon)),
                            const SizedBox(
                              width: 25,
                            ),
                            InkWell(
                                onTap: () async {
                                  await controller.facebookSignIn();
                                },
                                child: SvgPicture.asset(AssetConst.facebookIcon)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2800),
                        child: InkWell(
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
                      ),
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
