import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../src_exports.dart';

class ListTileWidget extends StatelessWidget {
  final bool badgeBool;
  final String title;
  final String subtitle;
  final int index;
  final DateTime date;

  ListTileWidget(
      {Key? key,
      required this.badgeBool,
      required this.title,
      required this.subtitle,
      required this.index,
      required this.date})
      : super(key: key);

  final TextEditingController titleCtrl = TextEditingController();

  final TextEditingController detailCtrl = TextEditingController();

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.greyColor),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, 0.3),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]
                ),
                child: ListTile(
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 240,
                              child: Text(
                                title,
                                maxLines: null,
                                style: const TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('MMM dd,' 'yyyy').format(date),
                              style: const TextStyle(color: AppColors.greyColor, fontSize: 13),
                            ),
                            SizedBox(
                                width: 250,
                                child: Text(
                                  subtitle,
                                  style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 15,
                                    overflow: TextOverflow.clip,
                                  ),
                                  maxLines: null,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            PopupMenuButton(
                              icon: const Icon(
                                Icons.more_horiz,
                                color: AppColors.textColor,
                              ),
                              itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: AppColors.deleteColor),
                                          ),
                                        )
                                      ];
                                    },
                              onSelected: (String value) {
                                if (value == "edit") {
                                  Get.bottomSheet(
                                      FadeInUpBig(
                                        duration: const Duration(seconds: 2),
                                        child: BottomFSheet(
                                            addL: 'edit',
                                            index: index,
                                            title: title,
                                            detail: subtitle,
                                            date: date,
                                            urgent: badgeBool),
                                      ),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      enableDrag: false);
                                } else if (value == "delete") {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return ZoomIn(
                                        duration: const Duration(milliseconds: 800),
                                        child: CupertinoAlertDialog(
                                          title: const Text('Please Confirm'),
                                          content: const Text('Are you sure to remove the task?'),
                                          actions: [
                                            // The "Yes" button
                                            CupertinoDialogAction(
                                              onPressed: () async {
                                                logger.i(controller.mainList[index].docId);
                                                await controller.delData(controller.mainList[index].docId);
                                              },
                                              isDefaultAction: true,
                                              isDestructiveAction: true,
                                              child: const Text('Delete'),
                                            ),
                                            // The "No" button
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              isDefaultAction: false,
                                              isDestructiveAction: false,
                                              child: const Text('Cancel'),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  // Get.defaultDialog(
                                  //     title: "",
                                  //     titleStyle: const TextStyle(
                                  //         color: AppColors.alertColor,
                                  //         fontWeight: FontWeight.bold),
                                  //     content: const Text(
                                  //       "Do you want delete...?",
                                  //       style: TextStyle(
                                  //           color: AppColors.textColor,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //     actions: [
                                  //       TextButton(
                                  //           onPressed: () {
                                  //             Get.back();
                                  //           },
                                  //           child: const Text(
                                  //             "Cancel",
                                  //             style: TextStyle(
                                  //                 color: AppColors.headingColor),
                                  //           )),
                                  //       ElevatedButton(
                                  //         onPressed: () async {
                                  //           logger.i(
                                  //               controller.mainList[index].docId);
                                  //           await controller.delData(
                                  //               controller.mainList[index].docId);
                                  //         },
                                  //         style: const ButtonStyle(
                                  //             backgroundColor:
                                  //                 MaterialStatePropertyAll(
                                  //                     AppColors.alertColor)),
                                  //         child: const Text("Delete"),
                                  //       )
                                  //     ]);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Badge(smallSize: 15, isLabelVisible: badgeBool, backgroundColor: AppColors.alertColor),
            ],
          ),
        );
      },
    );
  }
}