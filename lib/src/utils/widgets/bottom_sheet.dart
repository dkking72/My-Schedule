import 'package:intl/intl.dart';
import '../../../src_exports.dart';

class BottomFSheet extends StatelessWidget {
  final String addL;
  final int? index;
  final String? title;
  final String? detail;
  final DateTime date;
  final bool urgent;

  BottomFSheet(
      {super.key, required this.addL, this.index, this.title, this.detail, required this.date, this.urgent = false});

  final controller = Get.find<HomeController>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleCtrl = TextEditingController(text: title);
    final TextEditingController detailCtrl = TextEditingController(text: detail);
    final DateTime initialDate = date;
    final TextEditingController initialDateCtrl =
        TextEditingController(text: (DateFormat('MMM dd,' 'yyyy').format(date)));
    bool? important;
    // controller.check2 = urgent;
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Form(
          key: formKey,
          child: SizedBox(
            height: 650,
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin: const EdgeInsets.only(top: 70),
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: addL == "add"
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Title",
                                  style: TextStyle(color: AppColors.greyColor, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                TextFiledBox(
                                  hintText: 'Type Task Title',
                                  maxLines: 1,
                                  maxLength: 20,
                                  expands: false,
                                  textInputType: TextInputType.name,
                                  controller: titleCtrl,
                                  filteringTextInputFormatter: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        "[a-z A-Z á-ú Á-Ú 0-9]|[.,:_?'\"=^%\$\\-*&@#!\\/+\\\\()\\|]|[\\\\{}]|[\\[\\]]|[\\\\<>]")),
                                    FilteringTextInputFormatter.deny("  ", replacementString: " "),
                                    FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: ""),
                                  ],
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
                                      return 'Please enter some text or remove spaces';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Description",
                                  style: TextStyle(color: AppColors.greyColor, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 145,
                                      width: double.maxFinite,
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(
                                              "[a-z A-Z á-ú Á-Ú 0-9]|[.,:_?'\"=^%\$\\-*&@#!\\/+\\\\()\\|]|[\\\\{}]|[\\[\\]]|[\\\\<>]")),
                                          FilteringTextInputFormatter.deny("  ", replacementString: " "),
                                          FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                        ],
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              value.trim() == "" ||
                                              value.startsWith(" ")) {
                                            return 'Please enter some text or remove spaces';
                                          }
                                          return null;
                                        },
                                        focusNode: FocusNode(),
                                        controller: detailCtrl,
                                        keyboardType: TextInputType.name,
                                        maxLength: 150,
                                        maxLines: 5,
                                        expands: false,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Type Task Description',
                                          hintStyle: const TextStyle(color: AppColors.greyColor),
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
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
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
                                        enabled: true,
                                        onTap: () async {
                                          await controller.onDate();
                                        },
                                        readOnly: true,
                                        controller: controller.dateCtrl,
                                        style: const TextStyle(color: AppColors.black),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (controller.datePick == null) {
                                            return "Please Select Task Date";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          // hintText: controller.birthday.isNotEmpty
                                          //     ? controller.birthday
                                          //     : "Birthday",
                                          //hintText: controller.birthday.toDate().toString(),
                                          hintText: "Date",
                                          counterText: "",
                                          hintStyle: const TextStyle(color: AppColors.greyColor),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: AppColors.redColor)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: AppColors.redColor)),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors.greyColor),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(143, 148, 251, 0.3),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: CheckboxListTile(
                                      title: const Text(
                                        "Is this an urgent task?",
                                        style: TextStyle(color: AppColors.greyColor),
                                      ),
                                      activeColor: AppColors.darkPurple,
                                      value: controller.check,
                                      onChanged: (value) {
                                        controller.onVisibilityChanged();
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 55,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(AppColors.orangeColor)),
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            final d = TaskModel(
                                                title: titleCtrl.text,
                                                detail: detailCtrl.text,
                                                date: controller.datePick!,
                                                urgent: controller.check);
                                            controller.addData(taskData: d);
                                            controller.datePick = null;
                                            controller.dateCtrl.clear();
                                            controller.check = false;
                                          }
                                        },
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                  "Title",
                                  style: TextStyle(color: AppColors.greyColor, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                TextFiledBox(
                                  hintText: 'Type Task Title',
                                  maxLines: 1,
                                  maxLength: 20,
                                  expands: false,
                                  textInputType: TextInputType.name,
                                  controller: titleCtrl,
                                  filteringTextInputFormatter: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        "[a-z A-Z á-ú Á-Ú 0-9]|[.,:_?'\"=^%\$\\-*&@#!\\/+\\\\()\\|]|[\\\\{}]|[\\[\\]]|[\\\\<>]")),
                                    FilteringTextInputFormatter.deny("  ", replacementString: " "),
                                    FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                  ],
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty || value.trim() == "" || value.startsWith(" ")) {
                                      return 'Please enter some text or remove spaces';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Description",
                                  style: TextStyle(color: AppColors.greyColor, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 145,
                                      width: double.maxFinite,
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(
                                              "[a-z A-Z á-ú Á-Ú 0-9]|[.,:_?'\"=^%\$\\-*&@#!\\/+\\\\()\\|]|[\\\\{}]|[\\[\\]]|[\\\\<>]")),
                                          FilteringTextInputFormatter.deny("  ", replacementString: " "),
                                          FilteringTextInputFormatter.deny(RegExp("^[ ]"), replacementString: "")
                                        ],
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              value.trim() == "" ||
                                              value.startsWith(" ")) {
                                            return 'Please enter some text or remove spaces';
                                          }
                                          return null;
                                        },
                                        focusNode: FocusNode(),
                                        controller: detailCtrl,
                                        keyboardType: TextInputType.name,
                                        maxLength: 150,
                                        maxLines: 5,
                                        expands: false,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Type Task Description',
                                          hintStyle: const TextStyle(color: AppColors.greyColor),
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
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await controller.onDate();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(143, 148, 251, 0.3),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: TextFormField(
                                        enabled: false,
                                        controller:
                                            controller.dateCtrl.text.isEmpty ? initialDateCtrl : controller.dateCtrl,
                                        style: const TextStyle(color: AppColors.black),
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(color: AppColors.greyColor),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(color: AppColors.greyColor),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(143, 148, 251, 0.3),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: CheckboxListTile(
                                      title: const Text(
                                        "Is this an urgent task?",
                                        style: TextStyle(color: AppColors.greyColor),
                                      ),
                                      activeColor: AppColors.darkPurple,
                                      value: urgent == false ? controller.check : !controller.check,
                                      onChanged: (value) {
                                        logger.i(value);
                                        important = value;
                                        controller.onVisibilityChanged();
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 55,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(AppColors.orangeColor)),
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            logger.w(initialDate);
                                            logger.i(controller.mainList[index!].docId);
                                            final d = TaskModel(
                                                title: titleCtrl.text,
                                                detail: detailCtrl.text,
                                                date: controller.dateCtrl.text.isEmpty
                                                    ? initialDate
                                                    : controller.datePick!,
                                                urgent: important == null ? urgent : important!);
                                            controller.editData(d, controller.mainList[index!].docId);
                                            controller.datePick = null;
                                            controller.dateCtrl.clear();
                                            controller.check = false;
                                          }
                                        },
                                        child: const Text(
                                          "Edit",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 40,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.back();
                      controller.datePick = null;
                      controller.check = false;
                      controller.dateCtrl.clear();
                    },
                    backgroundColor: AppColors.darkPurple,
                    child: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
