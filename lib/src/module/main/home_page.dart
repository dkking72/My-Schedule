import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../src_exports.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (!controller.isSuccess) {
          return controller.view;
        }
        return Scaffold(
          backgroundColor: AppColors.bgPink,
          appBar: AppBar(
            toolbarHeight: 140,
            backgroundColor: AppColors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            // title: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     AnimatedTextKit(
            //       repeatForever: true,
            //       animatedTexts: [
            //         ColorizeAnimatedText("Welcome!",
            //             textStyle:
            //                 const TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.bold, fontSize: 24),
            //             colors: [AppColors.alertColor, AppColors.black, AppColors.amberColor]),
            //       ],
            //     ),
            //     AnimatedTextKit(
            //       repeatForever: true,
            //       animatedTexts: [
            //         ColorizeAnimatedText("I wish your best overcoming your challenges.",
            //             textStyle:
            //                 const TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.bold, fontSize: 24),
            //             colors: [AppColors.alertColor, AppColors.black, AppColors.amberColor]),
            //       ],
            //     ),
            //   ],
            //   ),
            title: FadeTransition(
              opacity: controller.animationCtrl,
              child: SlideTransition(
                position: controller.appbarAnimationPosition,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome!",
                        style: TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.bold, fontSize: 24)),
                    Text(
                      "I wish your best overcoming your challenges.",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              FadeTransition(
                opacity: controller.animationCtrl,
                child: SlideTransition(
                  position: controller.appbarAnimationPosition,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                      onTap: () async {
                        controller.x = await Get.toNamed(Routes.PROFILE_SCREEN)!.then((value) {
                              // x = value ?? "";
                              logger.i(value);
                              return value;
                            }) ??
                            "";
                        // try{
                        //   await Get.toNamed(Routes.PROFILE_SCREEN)!.then((value) => value == null ? "" : x = value);
                        //   logger.i(x);
                        // }catch(e){
                        //   logger.e(e);
                        // }
                        controller.update();
                        /*==========================================================*/
                        // Get.defaultDialog(
                        //     title: "",
                        //     titleStyle: const TextStyle(
                        //         color: AppColors.alertColor,
                        //         fontWeight: FontWeight.bold),
                        //     content: const Text(
                        //       "Do you want Logout...?",
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
                        //           await controller.logout();
                        //         },
                        //         style: const ButtonStyle(
                        //             backgroundColor:
                        //             MaterialStatePropertyAll(
                        //                 AppColors.orangeColor)),
                        //         child: const Text("Logout"),
                        //       )
                        //     ]);
                      },
                      child: Hero(
                        tag: 'ProfileImage',
                        transitionOnUserGestures: true,
                        child: controller.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 45,
                                // backgroundImage: controller.profileUrl.isEmpty
                                //     ? const AssetImage(AssetConst.uploadImage2) as ImageProvider
                                //     : CachedNetworkImageProvider(x.isNotEmpty ? x : controller.profileUrl),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2),
                                  ),
                                  child: ClipOval(
                                    child: controller.x.isNotEmpty
                                        ? Image.network(
                                            controller.x,
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
                                          )
                                        : controller.profileUrl.isEmpty
                                            ? Image.asset(
                                                AssetConst.uploadImage2,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                controller.profileUrl,
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
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: controller.animationCtrl,
                    child: SlideTransition(
                      position: controller.headerAnimationPosition,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Your Tasks",
                            style: TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(
                            "${controller.mainList.length} Tasks",
                            style: const TextStyle(color: AppColors.headingColor),
                          ),
                          IconButton(
                            onPressed: () async {
                              await controller.onDate2();
                              controller.datePick2 == null ? null : controller.filter(controller.datePick2!);
                            },
                            icon: const Icon(
                              CupertinoIcons.calendar_today,
                              size: 30,
                            ),
                            color: AppColors.textColor,
                          )
                          // SizedBox(
                          //   width: 100,
                          //   child: DropdownButtonFormField<String>(
                          //     hint: Text(
                          //       "Sorted By",
                          //       style: TextStyle(color: Colors.grey.shade800),
                          //     ),
                          //     items: ["Date", "Urgent", "Old"].map((e) {
                          //       return DropdownMenuItem<String>(
                          //           value: e, child: Text(e));
                          //     }).toList(),
                          //     onChanged: (newValue) {
                          //       // controller.select = newValue!;
                          //       // controller.filter(newValue);
                          //     },
                          //     value: controller.select,
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          // ),
                          // TextButton(
                          //     onPressed: () {
                          //       // controller.clearFilter();
                          //       // controller.filter("val");
                          //     },
                          //     child: const Text("Clear Filter")),
                        ],
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: controller.animationCtrl,
                    child: SlideTransition(
                      position: controller.taskButtonAnimationPosition,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                List<DateTime> pastDateList = [];
                                List<DateTime> futureDateList = [];
                                DateTime today = DateTime.now();
                                DateTime c = DateTime(today.year, today.month, today.day);
                                for (int i = 0; i < controller.f.length; i++) {
                                  if (controller.f[i].date.isBefore(c)) {
                                    pastDateList.any((element) =>
                                            DateFormat('MMM dd,' 'yyyy').format(element) ==
                                            DateFormat('MMM dd,' 'yyyy').format(controller.f[i].date))
                                        ? null
                                        : pastDateList.add(controller.f[i].date);
                                  }
                                  if (controller.f[i].date.isAfter(c)) {
                                    // DateFormat('MMM dd,' 'yyyy').format(futureDateList[i]) ==
                                    //     DateFormat('MMM dd,' 'yyyy').format(controller.f[i].date)
                                    //     ? null
                                    //     : futureDateList.add(controller.f[i].date);
                                    // List<String> temp = [];
                                    // temp.add(DateFormat('MMM dd,' 'yyyy').format(controller.f[i].date));
                                    // !temp.contains(DateFormat('MMM dd,' 'yyyy').format(futureDateList[i]))
                                    //     ? futureDateList.add(controller.f[i].date)
                                    //     : null;
                                    futureDateList.any((element) =>
                                            DateFormat('MMM dd,' 'yyyy').format(element) ==
                                            DateFormat('MMM dd,' 'yyyy').format(controller.f[i].date))
                                        ? null
                                        : futureDateList.add(controller.f[i].date);
                                  }
                                }
                                pastDateList.sort((a, b) => a.compareTo(b));
                                futureDateList.sort((a, b) => a.compareTo(b));
                                return ZoomIn(
                                  duration: const Duration(milliseconds: 1500),
                                  child: SimpleDialog(
                                    backgroundColor: AppColors.bgPink,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "TASK DATE",
                                          style: TextStyle(color: AppColors.headingColor),
                                        ),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.alertColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          child: IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                size: 18,
                                                color: AppColors.alertColor,
                                              )),
                                        )
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    children: [
                                      SizedBox(
                                        height: 400,
                                        width: double.maxFinite,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const ListTile(
                                                      title: Text("PAST TASK"),
                                                      titleTextStyle: TextStyle(color: AppColors.darkPurple),
                                                    ),
                                                    pastDateList.isEmpty
                                                        ? Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                AssetConst.pastTask,
                                                                height: 100,
                                                                width: 100,
                                                              ),
                                                              const Text(
                                                                "All Past Task Done",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: AppColors.textColor),
                                                              ),
                                                            ],
                                                          )
                                                        : ListView.builder(
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount: pastDateList.length,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                onTap: () {
                                                                  controller.filter(pastDateList[index]);
                                                                  controller.datePick2 = pastDateList[index];
                                                                  Get.back();
                                                                },
                                                                title: Text(
                                                                  DateFormat('MMM dd,' 'yyyy')
                                                                      .format(pastDateList[index]),
                                                                  style: const TextStyle(color: AppColors.textColor),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                    const SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const ListTile(
                                                      title: Text("FUTURE TASK"),
                                                      titleTextStyle: TextStyle(color: AppColors.darkPurple),
                                                    ),
                                                    futureDateList.isEmpty
                                                        ? Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                AssetConst.futureTask,
                                                                height: 100,
                                                                width: 100,
                                                              ),
                                                              const Text(
                                                                "No Future Task Pending",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: AppColors.textColor),
                                                              ),
                                                            ],
                                                          )
                                                        : ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemCount: futureDateList.length,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                onTap: () {
                                                                  controller.filter(futureDateList[index]);
                                                                  controller.datePick2 = futureDateList[index];
                                                                  Get.back();
                                                                },
                                                                title: Text(
                                                                  DateFormat('MMM dd,' 'yyyy')
                                                                      .format(futureDateList[index]),
                                                                  style: const TextStyle(color: AppColors.textColor),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.purple)),
                          child: const Text("All Task Date")),
                    ),
                  ),
                  controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : controller.mainList.isNotEmpty
                          // Flexible(
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: controller.mainList.length,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemBuilder: (context, index) {
                          //       Future.delayed(
                          //         const Duration(seconds: 1),
                          //             () {
                          //           startListAnimation = true;
                          //           controller.update();
                          //           return null;
                          //         },
                          //       );
                          //       return AnimatedContainer(
                          //           duration: Duration(milliseconds: 2500 + (index * 100)),
                          //           onEnd: () {
                          //             controller.update();
                          //           },
                          //           curve: Curves.easeInOut,
                          //           transform: Matrix4.translationValues(
                          //               startListAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
                          //           child: ListTileWidget(
                          //             badgeBool: controller.mainList[index].urgent,
                          //             title: controller.mainList[index].title,
                          //             subtitle: controller.mainList[index].detail,
                          //             index: index,
                          //             date: controller.mainList[index].date,
                          //           ));
                          //     },
                          //   ),
                          // )
                          ? Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.mainList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return FadeInRightBig(
                                    duration: const Duration(milliseconds: 1500),
                                    delay: const Duration(milliseconds: 700),
                                    child: ListTileWidget(
                                      badgeBool: controller.mainList[index].urgent,
                                      title: controller.mainList[index].title,
                                      subtitle: controller.mainList[index].detail,
                                      index: index,
                                      date: controller.mainList[index].date,
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Image.asset(AssetConst.workedDone,
                                      height: 300, gaplessPlayback: true, repeat: ImageRepeat.repeat),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Yay! You have no tasks on ${DateFormat('MMM dd,' 'yyyy').format(controller.datePick2 == null ? DateTime.now() : controller.datePick2!)}",
                                    style: const TextStyle(color: AppColors.purple, fontSize: 16),
                                  )
                                ],
                              ),
                            )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.darkPurple,
            onPressed: () {
              logger.i(FirebaseAuth.instance.currentUser!.uid);
              Get.bottomSheet(
                  FadeInUpBig(
                    duration: const Duration(seconds: 2),
                    child: BottomFSheet(
                      addL: 'add',
                      date: DateTime.now(),
                    ),
                  ),
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
