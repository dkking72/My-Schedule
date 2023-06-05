import "package:flutter/cupertino.dart";
import "package:intl/intl.dart";
import "../../../src_exports.dart";
import '../../plugin/date_picker.dart' as picker_date;

class HomeController extends BaseController with GetSingleTickerProviderStateMixin {
  final FirebaseFirestore firebaseDb = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late AnimationController animateController;
  late Animation<double> animationCtrl;
  late Animation<Offset> appbarAnimationPosition;
  late Animation<Offset> headerAnimationPosition;
  late Animation<Offset> taskButtonAnimationPosition;

  List<TaskModel> mainList = [];

  // var datePick = "";
  //
  // onDate() async {
  //   DateTime? pickedDate = await showDatePicker(
  //       context: Get.context!,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now(),
  //       //DateTime.now() - not to allow to choose before today.
  //       lastDate: DateTime(2100));
  //
  //   if (pickedDate != null) {
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     debugPrint(
  //         formattedDate); //formatted date output using intl package =>  2021-03-16
  //     datePick = formattedDate; //set output date to TextField value.
  //   } else {
  //     datePick = "";
  //     debugPrint("Date not selected");
  //   }
  //   onUpdate(status: Status.SCUSSESS);
  // }

  final TextEditingController dateCtrl2 = TextEditingController();
  DateTime? datePick2;

  onDate2() async {
    DateTime? pickedDate = await picker_date.showDatePicker(
      context: Get.context!,
      initialDate: datePick2 == null ? DateTime.now() : datePick2!,
      firstDate: DateTime(1950),
      lastDate: DateTime(2099),
      switchToCalendarEntryModeIcon: const Icon(CupertinoIcons.calendar_today),
      fieldLabelText: "Date",
      helpText: "MM/DD/YYYY",
      fieldHintText: "MM/DD/YYYY",
      errorInvalidText: "Please Enter Valid Date",
      errorFormatText: "MM/DD/YYYY",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.bgPink,
              onPrimary: AppColors.textColor,
              onSurface: AppColors.darkPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.deleteColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      // DateTime today = DateTime.now();
      datePick2 = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
      Timestamp timestamp = Timestamp.fromDate(datePick2!);
      // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // debugPrint(formattedDate); //formatted date output using intl package =>  2021-03-16
      // birthday = formattedDate; //set output date to TextField value.
      datePick2 = timestamp.toDate();
      logger.i("datePick2 ==> $datePick2");
      dateCtrl2.text = DateFormat('MMM dd,' 'yyyy').format(pickedDate);
    } else {
      logger.i(datePick2);
      debugPrint("Date not selected");
    }
    onUpdate();
  }

  final TextEditingController dateCtrl = TextEditingController();
  String x = "";

  @override
  void onInit() {
    onUpdate(status: Status.LOADING);
    getData();
    userProfileUrl();
    x = "";
    animateController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animationCtrl = CurvedAnimation(parent: animateController, curve: Curves.decelerate);
    appbarAnimationPosition =
        Tween<Offset>(begin: const Offset(0.0, -6.0), end: Offset.zero).animate(animateController);
    headerAnimationPosition = Tween<Offset>(begin: const Offset(2.0, 0.0), end: Offset.zero).animate(animateController);
    taskButtonAnimationPosition =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(animateController);
    animateController.forward();
    super.onInit();
  }

  DateTime? datePick;

  onDate() async {
    DateTime? pickedDate = await picker_date.showDatePicker(
        context: Get.context!,
        // initialDatePickerMode: DatePickerMode.year,
        initialDate: datePick2 == null ? DateTime.now() : datePick2!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2099),
        switchToCalendarEntryModeIcon: const Icon(CupertinoIcons.calendar_today),
        fieldLabelText: "Task Date",
        helpText: "MM/DD/YYYY",
        fieldHintText: "MM/DD/YYYY",
        errorInvalidText: "Please Enter Valid Date",
        errorFormatText: "MM/DD/YYYY",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.bgPink,
                onPrimary: AppColors.textColor,
                onSurface: AppColors.darkPurple,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.deleteColor,
                ),
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null) {
      DateTime today = DateTime.now();
      datePick = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, today.hour, today.minute, today.second,
          today.millisecond, today.microsecond);
      Timestamp timestamp = Timestamp.fromDate(datePick!);
      // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // debugPrint(formattedDate); //formatted date output using intl package =>  2021-03-16
      // birthday = formattedDate; //set output date to TextField value.
      datePick = timestamp.toDate();
      logger.i("datePick ==> $datePick");
      dateCtrl.text = DateFormat('MMM dd,' 'yyyy').format(pickedDate);
    } else {
      debugPrint("Date not selected");
    }
    onUpdate();
  }

  String profileUrl = "";

  Future<void> userProfileUrl() async {
    try {
      onUpdate(status: Status.LOADING);
      profileUrl = await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).get().then((e) {
        var model = UserData.fromJson(e.data() as Map<String, dynamic>).profileImgUrl;
        return model;
      });
      onUpdate(status: Status.SCUSSESS);
    } catch (e) {
      onError(e, () {});
    }
  }

  bool passwordVisible = true;

  onVisibilityChanged2() {
    passwordVisible = !passwordVisible;
    onUpdate();
  }

  bool check = false;

  onVisibilityChanged() {
    check = !check;
    onUpdate();
  }

  List<TaskModel> f = [];

  filter(DateTime selectDate) async {
    // mainList.clear();
    onUpdate(status: Status.LOADING);
    mainList = f;

    List<TaskModel> a = mainList
        .where((e) => DateFormat('yyyy-MM-dd').format(e.date) == DateFormat('yyyy-MM-dd').format(selectDate))
        .toList();
    List<TaskModel> allList = [];
    List<TaskModel> allUrgentList = a.where((element) => element.urgent == true).toList();
    // allUrgentList.sort((a, b) => a.date.compareTo(b.date));
    List<TaskModel> allNonUrgentList = a.where((element) => element.urgent == false).toList();
    // allNonUrgentList.sort((a, b) => a.date.compareTo(b.date));
    allList.addAll(allUrgentList);
    allList.addAll(allNonUrgentList);
    mainList = allList;
    onUpdate(status: Status.SCUSSESS);

    // if (val == "Date") {
    //   mainList.sort((a, b) => a.date.compareTo(b.date));
    //   update();
    // } else if (val == "Urgent") {
    //   List<TaskModel> allList = [];
    //   List<TaskModel> allUrgentList =
    //   f.where((element) => element.urgent == true).toList();
    //   allUrgentList.sort((a, b) => a.date.compareTo(b.date));
    //   List<TaskModel> allNonUrgentList =
    //       f.where((element) => element.urgent == false).toList();
    //   allNonUrgentList.sort((a, b) => a.date.compareTo(b.date));
    //   allList.addAll(allUrgentList);
    //   allList.addAll(allNonUrgentList);
    //   mainList = allList;
    //   update();
    // } else if (val == "Old") {
    //   List<TaskModel> a = f
    //       .where((element) => (element.date).isBefore(DateTime.now()))
    //       .toList();
    //   mainList = a;
    //   update();
    // } else {
    //   getData();
    //   update();
    // }
  }

  Future<void> addData({required TaskModel taskData}) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseDb.collection("task_collection").add(taskData.toJson());
      getData();
      // select = null;
      // onUpdate(status: Status.SCUSSESS);
      Get.back();
    } catch (e) {
      onError(e, () {});
    }
  }

  List<String> abc = [];

  Future<void> getData() async {
    try {
      onUpdate(status: Status.LOADING);
      f = await firebaseDb
          .collection("task_collection")
          .where('uid', isEqualTo: firebaseAuth.currentUser!.uid)
          .get()
          // .doc('OhmKqNhMkiWI1cAejiRLzJITkH92')
          // .doc(firebaseAuth.currentUser!.uid)
          // .collection("Document")
          // .get()
          .then((val) {
        return val.docs.map((e) {
          var model = TaskModel.fromJson(e.data());
          model.docId = e.id;
          return model;
        }).toList();
      });
      List<TaskModel> a = f
          .where((e) =>
              DateFormat('yyyy-MM-dd').format(e.date) ==
              DateFormat('yyyy-MM-dd').format(datePick2 == null ? DateTime.now() : datePick2!))
          .toList();
      a.sort((a, b) => b.date.compareTo(a.date));
      List<TaskModel> allList = [];
      List<TaskModel> allUrgentList = a.where((element) => element.urgent == true).toList();
      // allUrgentList.sort((a, b) => a.date.compareTo(b.date));
      List<TaskModel> allNonUrgentList = a.where((element) => element.urgent == false).toList();
      // allNonUrgentList.sort((a, b) => a.date.compareTo(b.date));
      allList.addAll(allUrgentList);
      allList.addAll(allNonUrgentList);
      mainList = allList;

      // for(int i = 0; i<f.length; i++){
      //   // DateFormat('MMM dd,' 'yyyy').format(f[i].date);
      //   if(!abc.contains(DateFormat('MMM dd,' 'yyyy').format(f[i].date))){
      //     abc.add(DateFormat('MMM dd,' 'yyyy').format(f[i].date));
      //   }}
      onUpdate(status: Status.SCUSSESS);
    } catch (e, t) {
      logger.i(t);
      onError(e, () {});
    }
  }

  Future<void> editData(TaskModel taskList, String id) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseDb
          .collection("task_collection")
          // .doc(firebaseAuth.currentUser!.uid)
          // .collection("Document")
          .doc(id)
          .update(taskList.toJson());
      // Future.delayed(Duration(seconds: 3),() => getData(),);
      // select = null;
      Get.back();
      getData();
    } catch (e) {
      onError(e, () {});
    }
  }

  Future<void> delData(String id) async {
    try {
      onUpdate(status: Status.LOADING);
      Get.back();
      logger.i(id);
      await firebaseDb
          .collection("task_collection")
          // .doc(firebaseAuth.currentUser!.uid)
          // .collection("Document")
          .doc(id)
          .delete();
      getData();
    } catch (e) {
      onError(e, () {});
    }
  }
}
