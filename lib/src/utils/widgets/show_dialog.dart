// import '../../../src_exports.dart';
//
// class ShowDialog extends StatelessWidget {
//   ShowDialog({super.key});
//
//   final controller = Get.find<HomeController>();
//   final TextEditingController titleCtrl = TextEditingController();
//   final TextEditingController detailCtrl = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GetBuilder<HomeController>(builder: (controller) {
//       if(controller.isSuccess){
//         return controller.view;
//       }
//       return AlertDialog(
//         title: const Text(
//           "Edit Box",
//           style: TextStyle(
//               color: AppColors.headingColor, fontWeight: FontWeight.bold),
//         ),
//         content: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Title",
//                 style: TextStyle(color: AppColors.greyColor, fontSize: 14),
//               ),
//               const SizedBox(
//                 height: 4,
//               ),
//               TextFiledBox(
//                   hintText: 'Title',
//                   maxLines: 1,
//                   maxLength: 20,
//                   expands: false,
//                   textInputType: TextInputType.text,
//                   controller: titleCtrl,
//                   filteringTextInputFormatter:
//                   FilteringTextInputFormatter.allow(
//                       RegExp("[a-z A-Z á-ú Á-Ú 0-9]"))),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "Description",
//                 style: TextStyle(color: AppColors.greyColor, fontSize: 14),
//               ),
//               const SizedBox(
//                 height: 4,
//               ),
//               SizedBox(
//                 height: 150,
//                 child: TextFiledBox(
//                   hintText: 'Type Task Description',
//                   maxLines: 5,
//                   maxLength: 150,
//                   expands: false,
//                   textInputType: TextInputType.name,
//                   controller: detailCtrl,
//                   filteringTextInputFormatter:
//                   FilteringTextInputFormatter.allow(RegExp(
//                       "[a-z A-Z á-ú Á-Ú 0-9]|[.,:_?'\"=^%\$\\-*&@#!\\/+\\\\()\\|]|[\\\\{}]|[\\[\\]]|[\\\\<>]")),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                 onTap: () async {
//                   await controller.onDate();
//                 },
//                 child: TextFormField(
//                     enabled: false,
//                     maxLength: 1,
//                     validator: (value) {
//                       if (controller.datePick.isEmpty) {
//                         return "Please Select Date";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       hintText: controller.datePick.isNotEmpty
//                           ? controller.datePick
//                           : "Date",
//                       hintStyle: const TextStyle(color: AppColors.greyColor),
//                       disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                               color: AppColors.greyColor, width: 1)),
//                       errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.red)),
//                     )),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Is this an urgent task?",
//                     style: TextStyle(color: AppColors.greyColor),
//                   ),
//                   Checkbox(
//                     // fillColor: MaterialStatePropertyAll(AppColors.purple),
//                       focusColor: AppColors.greyColor,
//                       activeColor: AppColors.darkPurple,
//                       value: controller.check,
//                       onChanged: (value) {
//                         controller.onVisibilityChanged();
//                       }),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//               onPressed: () {},
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: AppColors.textColor),
//               )),
//           ElevatedButton(
//             onPressed: () {},
//             style: const ButtonStyle(
//                 backgroundColor:
//                 MaterialStatePropertyAll(AppColors.orangeColor)),
//             child: const Text("Update"),
//           )
//         ],
//       );
//     },);
//   }
// }
