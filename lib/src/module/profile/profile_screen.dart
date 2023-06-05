import 'package:flutter/cupertino.dart';
import '../../../src_exports.dart';
import '../../plugin/zoom_in_out.dart' as custom_zoom;

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());



  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }

        logger.i(controller.userData!.toJson());
        // final TextEditingController fNameCtrl = TextEditingController(text: controller.userData!.fName);
        // final TextEditingController lNameCtrl = TextEditingController(text: controller.userData!.lName);
        // final TextEditingController birthdayCtrl = TextEditingController(
        //     text: DateFormat('MMM dd,' 'yyyy').format(controller.userData!.birthday) ==
        //         DateFormat('MMM dd,' 'yyyy').format(DateTime(0))
        //         ? ""
        //         : DateFormat('MMM dd,' 'yyyy').format(controller.userData!.birthday));
        return Scaffold(
          backgroundColor: AppColors.bgPink,
          body: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          FadeInDownBig(
                            duration: const Duration(seconds: 2),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                              child: Container(
                                height: 307,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          FadeInDownBig(
                            duration: const Duration(seconds: 2),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                              child: controller.userData!.coverImgUrl.isEmpty
                                  ? Image.asset(
                                      AssetConst.uploadImage,
                                      width: double.maxFinite,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      controller.userData!.coverImgUrl,
                                      width: double.maxFinite,
                                      height: 300,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          AssetConst.uploadImage,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return SizedBox(
                                          height: 300,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                          FadeInDownBig(
                            duration: const Duration(seconds: 2),
                            child: Container(
                              height: 325,
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.only(left: 15.0),
                              child: InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) => CupertinoActionSheet(
                                            title: const Text(
                                              "Cover Image",
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            actions: <Widget>[
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return SimpleDialog(
                                                        backgroundColor: Colors.transparent,
                                                        children: [
                                                          controller.userData!.coverImgUrl.isEmpty
                                                              ? Image.asset(AssetConst.uploadImage)
                                                              : Image.network(
                                                                  controller.userData!.coverImgUrl,
                                                                  width: double.maxFinite,
                                                                  errorBuilder: (context, error, stackTrace) {
                                                                    return Image.asset(
                                                                      AssetConst.uploadImage2,
                                                                      fit: BoxFit.cover,
                                                                    );
                                                                  },
                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                    if (loadingProgress == null) {
                                                                      return child;
                                                                    }
                                                                    return Center(
                                                                      child: CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes !=
                                                                                null
                                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                                loadingProgress.expectedTotalBytes!
                                                                            : null,
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Text("View Image"),
                                              ),
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () async {
                                                  Get.back();
                                                  await controller.coverImagePicker(controller.userData!.coverImgUrl);
                                                },
                                                child: const Text("Upload New Cover Image"),
                                              )
                                            ],
                                            cancelButton: CupertinoActionSheetAction(
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                          ));
                                  // await controller.coverImagePicker();
                                },
                                child: const CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.orangeColor,
                                  child: Icon(Icons.add_photo_alternate, color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                          custom_zoom.ZoomIn(
                            duration: const Duration(seconds: 2),
                            child: Container(
                              height: 370,
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(width: 4),
                                          borderRadius: BorderRadius.circular(150)),
                                      child: ClipOval(
                                        child: Hero(
                                          transitionOnUserGestures: true,
                                          tag: 'ProfileImage',
                                          child: controller.userData!.profileImgUrl.isEmpty
                                              ? Image.asset(
                                                  AssetConst.uploadImage2,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  controller.userData!.profileImgUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(
                                                      AssetConst.uploadImage2,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  loadingBuilder: (context, child, loadingProgress) {
                                                    if (loadingProgress == null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                        value: loadingProgress.expectedTotalBytes != null
                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                loadingProgress.expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () async {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) => CupertinoActionSheet(
                                                    title: const Text(
                                                      "Profile Image",
                                                      style: TextStyle(fontSize: 24),
                                                    ),
                                                    actions: <Widget>[
                                                      CupertinoActionSheetAction(
                                                        isDefaultAction: true,
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return SimpleDialog(
                                                                backgroundColor: Colors.transparent,
                                                                children: [
                                                                  Hero(
                                                                    tag: "ProfileImage",
                                                                    transitionOnUserGestures: true,
                                                                    child: controller.userData!.profileImgUrl.isEmpty
                                                                        ? Image.asset(AssetConst.uploadImage2)
                                                                        : Image.network(
                                                                            controller.userData!.profileImgUrl,
                                                                            errorBuilder: (context, error, stackTrace) {
                                                                              return Image.asset(
                                                                                AssetConst.uploadImage2,
                                                                                fit: BoxFit.cover,
                                                                              );
                                                                            },
                                                                            loadingBuilder:
                                                                                (context, child, loadingProgress) {
                                                                              if (loadingProgress == null) {
                                                                                return child;
                                                                              }
                                                                              return Center(
                                                                                child: CircularProgressIndicator(
                                                                                  value: loadingProgress
                                                                                              .expectedTotalBytes !=
                                                                                          null
                                                                                      ? loadingProgress
                                                                                              .cumulativeBytesLoaded /
                                                                                          loadingProgress
                                                                                              .expectedTotalBytes!
                                                                                      : null,
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text("View Image"),
                                                      ),
                                                      CupertinoActionSheetAction(
                                                        isDefaultAction: true,
                                                        onPressed: () async {
                                                          Get.back();
                                                          await controller
                                                              .profileImagePicker(controller.userData!.profileImgUrl);
                                                        },
                                                        child: const Text("Upload New Profile Image"),
                                                      )
                                                    ],
                                                    cancelButton: CupertinoActionSheetAction(
                                                      isDestructiveAction: true,
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Text("Cancel"),
                                                    ),
                                                  ));
                                          // await controller.profileImagePicker();
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: const CircleAvatar(
                                          radius: 24,
                                          backgroundColor: AppColors.orangeColor,
                                          child: Icon(Icons.add_photo_alternate, color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: controller.profileFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  child: DisableTextField(
                                    controller: controller.fNameCtrl,
                                    // initialValue: controller.userData?.fName,
                                    labelName: 'FIRST NAME',
                                    enabled: controller.profileEditing,
                                    filteringTextInputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                                      FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                    ],
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == "" ||
                                          value.startsWith(" ")) {
                                        return 'Please enter some text or remove spaces';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 600),
                                  child: DisableTextField(
                                    // initialValue: controller.userData!.lName,
                                    controller: controller.lNameCtrl,
                                    labelName: 'LAST NAME',
                                    enabled: controller.profileEditing,
                                    filteringTextInputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                                      FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                    ],
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == "" ||
                                          value.startsWith(" ")) {
                                        return 'Please enter some text or remove spaces';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 800),
                                  child: DisableTextField(
                                    // initialValue: DateFormat('MMM dd,' 'yyyy').format(controller.userData!.birthday) ==
                                    //     DateFormat('MMM dd,' 'yyyy').format(DateTime(0))
                                    //     ? ""
                                    //     : DateFormat('MMM dd,' 'yyyy').format(controller.userData!.birthday),
                                    onTap: () async {
                                      controller.profileEditing
                                          ? await controller.onDate(controller.userData!.birthday == DateTime(0)
                                              ? DateTime(1990)
                                              : controller.userData!.birthday)
                                          : null;
                                    },
                                    controller:
                                        controller.birthdayCtrl.text.isEmpty ? controller.birthdayCtrlV : controller.birthdayCtrl,
                                    labelName: 'BIRTHDAY',
                                    enabled: controller.profileEditing,
                                    readOnly: true,
                                    filteringTextInputFormatter: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                                      FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                    ],
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == "" ||
                                          value.startsWith(" ")) {
                                        return 'Please enter some text or remove spaces';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 1000),
                                  child: TextFormField(
                                      enabled: false,
                                      controller: controller.userData!.phone.isEmpty
                                          ? null
                                          : TextEditingController(
                                              text:
                                                  '${controller.userData!.countryCode} ${controller.userData!.phone}'),
                                      style: const TextStyle(color: AppColors.black),
                                      decoration: InputDecoration(
                                        labelText: "PHONE",
                                        suffixIcon: controller.userData!.phone.isEmpty
                                            ? null
                                            : controller.userData!.phoneVerified
                                                ? const Icon(Icons.verified, color: AppColors.purple)
                                                : const Icon(Icons.verified_outlined, color: AppColors.purple),
                                        labelStyle:
                                            const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
                                        hintStyle: const TextStyle(color: AppColors.greyColor),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: AppColors.defaultPurple, width: 2)),
                                      )),
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 1200),
                                  child: Align(
                                      heightFactor: 0.6,
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                          onPressed: () {
                                            // String n = controller.country.isEmpty ? controller.userData!.countryCode : "+${controller.country}";
                                            // logger.i('$n ${controller.userData!.phone}');
                                            // await controller.phoneVerification('$n ${controller.userData!.phone}');
                                            controller.phoneVisible = false;
                                            controller.country = controller.userData!.countryCode.isEmpty
                                                ? "+91"
                                                : controller.userData!.countryCode;
                                            Get.toNamed(Routes.PHONE_VERIFICATION_SCREEN,
                                                arguments: [controller.userData!.phone]);
                                            controller.onUpdate();
                                          },
                                          child: controller.userData!.phone.isEmpty
                                              ? const Text("Enter Phone Number")
                                              : !controller.userData!.phoneVerified
                                                  ? const Text("Go to Verification")
                                                  : const Text("Edit Phone Number"))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 1400),
                                  child: TextFormField(
                                      enabled: false,
                                      controller: TextEditingController(text: controller.userData!.email),
                                      style: const TextStyle(color: AppColors.black),
                                      decoration: InputDecoration(
                                        labelText: "EMAIL",
                                        suffixIcon: controller.userData!.emailVerified
                                            ? const Icon(Icons.verified, color: AppColors.purple)
                                            : const Icon(Icons.verified_outlined, color: AppColors.purple),
                                        labelStyle:
                                            const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
                                        hintStyle: const TextStyle(color: AppColors.greyColor),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: AppColors.defaultPurple, width: 2)),
                                      )),
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 1600),
                                  child: Align(
                                      heightFactor: 0.6,
                                      alignment: Alignment.centerRight,
                                      child: Visibility(
                                        visible: !controller.userData!.googleSign && !controller.userData!.facebookSign,
                                        child: TextButton(
                                            onPressed: () {
                                              controller.emailVisible = false;
                                              Get.toNamed(Routes.EMAIL_VERIFICATION_SCREEN,
                                                  arguments: [controller.userData]);
                                              controller.update();
                                            },
                                            child: !controller.userData!.emailVerified
                                                ? const Text("Go to Verification")
                                                : const Text("Edit Email Address")),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 1800),
                                  child: Column(
                                    children: [
                                      const Center(
                                          child: Text(
                                        "Link with Social Media...!",
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
                                                if (!controller.userData!.googleSign) {
                                                  logger.i(controller.userData!.googleSign);
                                                  await controller.googleLinkCred();
                                                } else {
                                                  Get.snackbar(
                                                    "You Are already LogIn With Google",
                                                    "",
                                                    padding: const EdgeInsets.only(top: 25.0),
                                                    icon: const Icon(Icons.person, color: AppColors.black),
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    shouldIconPulse: false,
                                                    margin:
                                                        const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                                                    backgroundColor: AppColors.greenColor,
                                                  );
                                                }
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
                                                if (!controller.userData!.facebookSign) {
                                                  logger.i(controller.userData!.facebookSign);
                                                  await controller.facebookLinkCred();
                                                } else {
                                                  Get.snackbar(
                                                    "You Are already LogIn With Facebook",
                                                    "",
                                                    padding: const EdgeInsets.only(top: 25.0),
                                                    icon: const Icon(Icons.person, color: AppColors.black),
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    backgroundColor: AppColors.greenColor,
                                                    shouldIconPulse: false,
                                                    margin:
                                                        const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                                                  );
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                AssetConst.facebookIcon,
                                                height: 38,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                FadeInUpBig(
                                    duration: const Duration(seconds: 2),
                                    delay: const Duration(milliseconds: 2000),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        height: 60,
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              controller.profileEditing = !controller.profileEditing;
                                              if (controller.profileFormKey.currentState!.validate() &&
                                                  !controller.profileEditing) {
                                                final d = UserData(
                                                    fName: controller.fNameCtrl.text,
                                                    lName: controller.lNameCtrl.text,
                                                    phone: controller.userData!.phone,
                                                    email: controller.userData!.email,
                                                    coverImgUrl: controller.userData!.coverImgUrl,
                                                    birthday: controller.birthdayDateTime == null
                                                        ? controller.userData!.birthday
                                                        : controller.birthdayDateTime!,
                                                    profileImgUrl: controller.userData!.profileImgUrl,
                                                    phoneVerified: controller.userData!.phoneVerified,
                                                    emailVerified: controller.userData!.emailVerified,
                                                    countryCode: controller.userData!.countryCode,
                                                    facebookSign: controller.userData!.facebookSign,
                                                    googleSign: controller.userData!.googleSign);
                                                await controller.editUserData(userData: d);
                                              } else {
                                                logger.i("else part");
                                                controller.profileEditing = true;
                                                controller.update();
                                              }
                                              if (!controller.profileFormKey.currentState!.validate() &&
                                                  controller.profileEditing) {
                                                Get.snackbar(
                                                  "Enter all Text field...",
                                                  "Otherwise your profile can't be updated.",
                                                  icon: const Icon(Icons.person, color: AppColors.white),
                                                  snackPosition: SnackPosition.BOTTOM,
                                                  shouldIconPulse: false,
                                                  colorText: AppColors.white,
                                                  margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                                                  backgroundColor: AppColors.alertColor,
                                                );
                                              }
                                            },
                                            style: const ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(AppColors.darkPurple),
                                            ),
                                            child: controller.profileEditing
                                                ? const Text("Save Profile")
                                                : const Text("Edit Profile")),
                                      ),
                                    )),
                                FadeInUpBig(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(milliseconds: 2200),
                                  child: TextButton(
                                      onPressed: () {
                                        showCupertinoDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: const Text('Please Confirm'),
                                              content: const Text('Do you want to Logout...?'),
                                              actions: [
                                                // The "Yes" button
                                                CupertinoDialogAction(
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.logout();
                                                  },
                                                  isDefaultAction: true,
                                                  isDestructiveAction: true,
                                                  child: const Text('Logout'),
                                                ),
                                                // The "No" button
                                                CupertinoDialogAction(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  isDefaultAction: false,
                                                  isDestructiveAction: false,
                                                  child: const Text('Stay'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "LOGOUT",
                                        style: TextStyle(color: AppColors.textColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: PhysicalModel(
                    color: AppColors.darkPurple,
                    elevation: 10.0,
                    shadowColor: AppColors.darkPurple,
                    borderRadius: BorderRadius.circular(40),
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          Get.back(result: controller.userData!.profileImgUrl);
                        }),
                  ),
                ),
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: AppColors.orangeColor,
          //   onPressed: () {
          //     Get.bottomSheet(
          //       FadeInUpBig(
          //         duration: const Duration(seconds: 2),
          //         child: ProfileBottomSheet(
          //           fName: controller.userData!.fName,
          //           lName: controller.userData!.lName,
          //           phone: controller.userData!.phone,
          //           email: controller.userData!.email,
          //           coverImg: controller.userData!.coverImgUrl,
          //           birthday: controller.userData!.birthday,
          //           profileImg: controller.userData!.profileImgUrl,
          //           phoneVerified: controller.userData!.phoneVerified,
          //           emailVerified: controller.userData!.emailVerified,
          //           country: controller.userData!.countryCode,
          //           facebookSign: controller.userData!.facebookSign,
          //           googleSign: controller.userData!.googleSign,
          //         ),
          //       ),
          //       isScrollControlled: true,
          //       isDismissible: false,
          //       enableDrag: false,
          //     );
          //   },
          //   child: const Icon(Icons.edit),
          // ),
        );
      },
    );
  }
}
