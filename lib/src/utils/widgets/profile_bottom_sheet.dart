// import 'package:intl/intl.dart';
// import 'package:my_schedule/src_exports.dart';
//
// class ProfileBottomSheet extends StatelessWidget {
//   final String fName;
//   final String lName;
//   final String phone;
//   final String email;
//   final DateTime birthday;
//   final String coverImg;
//   final String profileImg;
//   final bool phoneVerified;
//   final bool emailVerified;
//   final String country;
//   final bool facebookSign;
//   final bool googleSign;
//
//   ProfileBottomSheet(
//       {Key? key,
//       required this.fName,
//       required this.lName,
//       required this.phone,
//       required this.email,
//       required this.birthday,
//       required this.coverImg,
//       required this.profileImg,
//       required this.phoneVerified,
//       required this.emailVerified,
//       required this.country,
//       required this.facebookSign,
//       required this.googleSign})
//       : super(key: key);
//
//   final profileController = Get.find<ProfileController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController fNameCtrl = TextEditingController(text: fName);
//     final TextEditingController lNameCtrl = TextEditingController(text: lName);
//     final TextEditingController phoneCtrl = TextEditingController(text: phone);
//     final TextEditingController emailCtrl = TextEditingController(text: email);
//     String initCountry = country;
//     final TextEditingController initialBirthdayCtrl =
//         TextEditingController(text: DateFormat('MMM dd,' 'yyyy').format(birthday));
//
//     return GetBuilder<ProfileController>(
//       builder: (controller) {
//         if (!controller.isSuccess) {
//           return controller.view;
//         }
//         return Form(
//             key: controller.profileFormKey2,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         width: double.maxFinite,
//                         margin: const EdgeInsets.only(top: 70),
//                         padding: const EdgeInsets.all(15.0),
//                         decoration: const BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius:
//                                 BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//                         child: FadeInUp(
//                           duration: const Duration(seconds: 3),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const SizedBox(
//                                 height: 25,
//                               ),
//                               const Text("FIRST NAME"),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               TextFiledBox(
//                                 hintText: "FIRST NAME",
//                                 maxLines: 1,
//                                 maxLength: 20,
//                                 expands: false,
//                                 textInputType: TextInputType.name,
//                                 controller: fNameCtrl,
//                                 filteringTextInputFormatter: [
//                                   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
//                                   FilteringTextInputFormatter.deny("  ", replacementString: " "),
//                                   FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
//                                 ],
//                                 validator: (String? value) {
//                                   if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
//                                     return 'Please enter some text or remove spaces';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               const Text("LAST NAME"),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               TextFiledBox(
//                                 hintText: "LAST NAME",
//                                 maxLines: 1,
//                                 maxLength: 20,
//                                 expands: false,
//                                 textInputType: TextInputType.name,
//                                 controller: lNameCtrl,
//                                 filteringTextInputFormatter: [
//                                   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
//                                   FilteringTextInputFormatter.deny("  ", replacementString: " "),
//                                   FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
//                                 ],
//                                 validator: (String? value) {
//                                   if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
//                                     return 'Please enter some text or remove spaces';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               const Text("BIRTHDAY"),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//                                   await controller.onDate(birthday == DateTime(0) ? DateTime(1990) : birthday);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: AppColors.white,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             color: Color.fromRGBO(143, 148, 251, 0.3),
//                                             blurRadius: 20.0,
//                                             offset: Offset(0, 10))
//                                       ]),
//                                   child: TextFormField(
//                                       enabled: false,
//                                       controller: controller.birthdayCtrl.text.isEmpty
//                                           ? initialBirthdayCtrl
//                                           : controller.birthdayCtrl,
//                                       style: const TextStyle(color: AppColors.black),
//                                       decoration: InputDecoration(
//                                         // hintText: controller.birthday.isNotEmpty
//                                         //     ? controller.birthday
//                                         //     : "Birthday",
//                                         //hintText: controller.birthday.toDate().toString(),
//                                         hintText: "BIRTHDAY",
//                                         hintStyle: const TextStyle(color: AppColors.greyColor),
//                                         disabledBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(10),
//                                             borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
//                                         errorBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(10),
//                                             borderSide: const BorderSide(color: Colors.red)),
//                                       )),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: SizedBox(
//                                   height: 60,
//                                   width: double.maxFinite,
//                                   child: ElevatedButton(
//                                       style: const ButtonStyle(
//                                           backgroundColor: MaterialStatePropertyAll(AppColors.darkPurple)),
//                                       onPressed: () async {
//                                         if (controller.profileFormKey2.currentState!.validate()) {
//                                           final d = UserData(
//                                               fName: fNameCtrl.text,
//                                               lName: lNameCtrl.text,
//                                               birthday: controller.birthdayCtrl.text.isEmpty
//                                                   ? birthday
//                                                   : controller.birthdayDateTime!,
//                                               email: emailCtrl.text,
//                                               emailVerified: emailVerified,
//                                               phoneVerified: phoneVerified,
//                                               countryCode: profileController.country.isEmpty
//                                                   ? initCountry
//                                                   : "+${profileController.country}",
//                                               phone: phoneCtrl.text,
//                                               coverImgUrl: coverImg,
//                                               profileImgUrl: profileImg,
//                                               facebookSign: facebookSign,
//                                               googleSign: googleSign);
//                                           await controller.editUserData(userData: d);
//                                           controller.birthdayDateTime = null;
//                                           controller.birthdayCtrl.clear();
//                                           controller.country = "";
//                                         } else {}
//                                       },
//                                       child: const Text(
//                                         "PROFILE EDIT",
//                                         style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//                                       )),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         right: 10,
//                         top: 40,
//                         child: FloatingActionButton(
//                           onPressed: () {
//                             Get.back();
//                             controller.birthdayCtrl.clear();
//                             controller.birthdayDateTime = null;
//                             controller.country = "";
//                           },
//                           backgroundColor: AppColors.darkPurple,
//                           child: const Icon(Icons.close),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }
