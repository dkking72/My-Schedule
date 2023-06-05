import '../../../src_exports.dart';

class Verification extends StatelessWidget {
  Verification({super.key});

  final UserData userData = Get.arguments[0];
  final controller = Get.find<AuthController>();
  final GlobalKey<FormState> verificationFormKey = GlobalKey<FormState>();
  final TextEditingController codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneCtrl = TextEditingController(text: userData.phone);
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Form(
          key: verificationFormKey,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              // leading: IconButton(
              //     icon: const Icon(
              //       Icons.arrow_back_ios_new,
              //       color: AppColors.headingColor,
              //     ),
              //     onPressed: () {
              //       Get.back();
              //     }),
              actions: [
                TextButton(onPressed: (){
                  Get.offAllNamed(Routes.HOME_PAGE);
                  controller.update();
                }, child: const Text("Skip",style: TextStyle(color: AppColors.purple),))
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const FadeInImage(
                        placeholder: AssetImage(AssetConst.loader),
                        image: AssetImage(AssetConst.verification),
                        height: 300,
                        width: 300,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      !controller.signUpBool
                          ? Column(
                              children: [
                                Row(
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
                                              ]
                                          ),
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
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(onPressed: () async {
                                  codeCtrl.clear();
                                  await controller.sendOTP(number: phoneCtrl.text);
                                }, child: const Text("Send Otp")),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  "Otp Sending On this Number +${controller.country} ${controller.phoneNumber}",
                                  style: const TextStyle(color: AppColors.textColor),
                                ),
                                TextButton(onPressed: (){
                                  controller.signUpBool = !controller.signUpBool;
                                  controller.update();
                                }, child: const Text("Phone number edit")),
                                const SizedBox(
                                  height: 10,
                                ),
                                Pinput(
                                  controller: codeCtrl,
                                  length: 6,
                                  toolbarEnabled: false,
                                  validator: (e) {
                                    if (e!.isEmpty || e.length < 6) {
                                      return "Enter Valid Pin";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 45,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(AppColors.darkPurple)),
                                        onPressed: () async {
                                          if (verificationFormKey.currentState!.validate()) {
                                            await controller.verifyOtp(codeCtrl.text.trim());
                                            codeCtrl.clear();
                                          } else {
                                            logger.wtf("Confirm Button");
                                          }
                                        },
                                        child: const Text(
                                          "Confirm",
                                          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 45,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(AppColors.amberColor)),
                                        onPressed: () async {
                                          !controller.timerVisible ? null : await controller.sendOTP(number: phoneCtrl.text);
                                          codeCtrl.clear();
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.timer),
                                            Text(
                                              controller.timerVisible ? "Send OTP" : controller.time,
                                              style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                      // PinCodeTextField(
                      //   appContext: Get.context!,
                      //   length: 6,
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      //   obscureText: false,
                      //   animationType: AnimationType.fade,
                      //   controller: controller.codeCtrl,
                      //   validator: (value) {
                      //     // logger.i(controller.country.length + value!.length);
                      //     // String a = controller.country;
                      //     // String pattern = '/^$a(?:\W*\d){0,13}\d$/gm';
                      //     // RegExp regExp = RegExp(pattern);
                      //     // if (value.isEmpty) {
                      //     //   return 'Please enter mobile number';
                      //     // }
                      //     // else if (!regExp.hasMatch(value)) {
                      //     //   return 'Please enter valid mobile number';
                      //     // }
                      //     // return null;
                      //     return value!.length < 6 ? 'Code Invalid' : null;
                      //   },
                      //   pinTheme: PinTheme(
                      //     shape: PinCodeFieldShape.box,
                      //     borderRadius: BorderRadius.circular(5),
                      //     fieldHeight: 50,
                      //     fieldWidth: 40,
                      //     activeFillColor: AppColors.white,
                      //   ),
                      //   animationDuration: const Duration(milliseconds: 300),
                      //   backgroundColor: AppColors.white,
                      //   enableActiveFill: true,
                      //   // errorAnimationController: errorController,
                      //   onCompleted: (v) {
                      //     debugPrint("Completed");
                      //   },
                      //   onChanged: (value) {
                      //     debugPrint(value);
                      //     // setState(() {
                      //     //   currentText = value;
                      //     // });
                      //   },
                      //   beforeTextPaste: (text) {
                      //     debugPrint("Allowing to paste $text");
                      //     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //     //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      //     return true;
                      //   },
                      // ),
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   controller: codeCtrl,
                      //   maxLines: 1,
                      //   maxLength: 6,
                      //   validator: (value) {
                      //     // logger.i(controller.country.length + value!.length);
                      //     // String a = controller.country;
                      //     // String pattern = '/^$a(?:\W*\d){0,13}\d$/gm';
                      //     // RegExp regExp = RegExp(pattern);
                      //     // if (value.isEmpty) {
                      //     //   return 'Please enter mobile number';
                      //     // }
                      //     // else if (!regExp.hasMatch(value)) {
                      //     //   return 'Please enter valid mobile number';
                      //     // }
                      //     // return null;
                      //     return value!.length < 6
                      //         ? 'Code Invalid'
                      //         : null;
                      //   },
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.allow(
                      //         RegExp("[0-9]")),
                      //   ],
                      //   decoration: InputDecoration(
                      //     hintText: "Code",
                      //     hintStyle: const TextStyle(
                      //       color: AppColors.greyColor,
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: const BorderSide(
                      //             color: AppColors.greyColor, width: 1)),
                      //     focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: const BorderSide(
                      //             color: AppColors.purple, width: 2)),
                      //     errorBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide:
                      //         const BorderSide(color: Colors.red)),
                      //     focusedErrorBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide:
                      //         const BorderSide(color: Colors.red)),
                      //   ),
                      // ),
                      // TextFiledBox(
                      //     hintText: "Code",
                      //     maxLines: 1,
                      //     maxLength: 6,
                      //     expands: false,
                      //     textInputType: TextInputType.number,
                      //     controller: codeCtrl,
                      //     filteringTextInputFormatter:
                      //         FilteringTextInputFormatter.allow(RegExp("[0-9]"))),
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
