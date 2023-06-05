import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../src_exports.dart';
import '../../plugin/date_picker.dart' as picker_date;

class ProfileController extends BaseController {

  final TextEditingController fNameCtrl = TextEditingController();
  final TextEditingController lNameCtrl = TextEditingController();
  final TextEditingController birthdayCtrlV = TextEditingController();

  final FirebaseFirestore firebaseDb = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> profileFormKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneVerificationFormKey = GlobalKey<FormState>();
  bool phoneVisible = false;
  bool emailVisible = false;
  bool passwordVisible = true;
  bool profileEditing = false;

  onVisibilityChanged() {
    passwordVisible = !passwordVisible;
    onUpdate();
  }

  @override
  void onInit() {
    onUpdate(status: Status.LOADING);
    getUserdata();
    super.onInit();
  }

  final TextEditingController birthdayCtrl = TextEditingController();
  DateTime? birthdayDateTime;

  onDate(DateTime init) async {
    DateTime? pickedDate = await picker_date.showDatePicker(
        context: Get.context!,
        initialDate: birthdayDateTime == null ? init : birthdayDateTime!,
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().subtract(const Duration(hours: 157788)),
        switchToCalendarEntryModeIcon: const Icon(CupertinoIcons.calendar_today),
        fieldLabelText: "Birthday Date",
        helpText: "MM/DD/YYYY",
        fieldHintText: "MM/DD/YYYY",
        errorInvalidText: "Please Enter Valid Birthday",
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
      Timestamp timestamp = Timestamp.fromDate(pickedDate);
      birthdayDateTime = timestamp.toDate();
      logger.i(DateFormat('MMM dd,' 'yyyy').format(pickedDate));
      birthdayCtrl.text = DateFormat('MMM dd,' 'yyyy').format(pickedDate);
      pickedDate = null;
      logger.w(pickedDate);
    } else {
      debugPrint("Date not selected");
    }
    update();
  }

  var country = "";

  countryCode() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: AppColors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        // margin: EdgeInsets.only(top: 100),
        bottomSheetHeight: 700,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: AppColors.greyColor),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.purple.withOpacity(0.5),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.purple, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.purple, width: 2)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.purple, width: 1)),
        ),
      ),
      onSelect: (Country e) {
        country = '+${e.phoneCode}';
        logger.i('Select countryCode: $country');
        onUpdate();
      },
    );
  }

  String profileImage = "";
  String coverImage = "";

  Future<void> profileImagePicker(String profileUrl) async {
    try {
      onUpdate(status: Status.LOADING);
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null) {
        // List<String> files = [];
        profileImage = result.files.first.path!;
        logger.i(result.files.first.name);
        logger.i(profileImage);
        // List<String> a = await firebaseStorage
        //     .ref("user_details").list()
        //     .then((e) => e.items.map((e) => e.getDownloadURL().toString()).toList());
        // logger.i(a);
        profileUrl.isEmpty
            ? null
            : (profileUrl.contains("https://firebasestorage.googleapis.com/")
                ? await firebaseStorage.refFromURL(profileUrl).delete()
                : null);
        String fileName = DateTime.now().toString();
        await firebaseStorage.ref('Images/$fileName').putFile(File(profileImage));
        await firebaseStorage.ref('Images/$fileName').getDownloadURL().then((value) =>
            firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).update({'profile_img': value}));
      } else {
        logger.d("Image not Pick");
      }
      getUserdata();
    } catch (e, t) {
      logger.e(e);
      logger.e(t);
    }
  }

  Future<void> coverImagePicker(String coverUrl) async {
    try {
      onUpdate(status: Status.LOADING);
      // ListResult results = await FirebaseStorage.instance.ref('Images').listAll();

      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null) {
        // List<String> files = [];
        coverImage = result.files.first.path!;
        logger.i(result.files.first.name);
        logger.i(coverImage);
        //     var admin = require("firebase-admin");
        //     var bucket = admin.storage().bucket('my-schedule-2d32b.appspot.com/Images');
        //
        //     var storageFile = bucket.file('path/to/file.txt');
        //     storageFile
        //         .exists()
        //         .then(() {
        //     logger.i("File exists");
        //     })
        //     .printError(() {
        // logger.i("File doesn't exist");
        // });
        coverImage.isEmpty
            ? null
            : (coverImage.contains("https:") ? await firebaseStorage.refFromURL(coverUrl).delete() : null);
        String fileName = DateTime.now().toString();
        await firebaseStorage.ref('Images/$fileName').putFile(File(coverImage));
        await firebaseStorage.ref('Images/$fileName').getDownloadURL().then((value) =>
            firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).update({'cover_img': value}));
      } else {
        logger.d("Image Not Pick");
      }
      getUserdata();
    } catch (e) {
      logger.e(e);
    }
  }

  UserData? userData;

  Future<void> getUserdata() async {
    try {
      onUpdate(status: Status.LOADING);
      userData = await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).get().then((e) {
        var model = UserData.fromJson(e.data() as Map<String, dynamic>);
        // model.docId = e.id;
        // logger.w(model.docId);
        return model;
      });
      fNameCtrl.text = userData!.fName;
      lNameCtrl.text = userData!.lName;
      birthdayCtrl.text = DateFormat('MMM dd,' 'yyyy').format(userData!.birthday) ==
          DateFormat('MMM dd,' 'yyyy').format(DateTime(0))
          ? ""
          : DateFormat('MMM dd,' 'yyyy').format(userData!.birthday);
      onUpdate(status: Status.SCUSSESS);
    } catch (e, t) {
      logger.d(t);
      onError(e, () {});
    }
  }

  Future<void> editUserData({required UserData userData}) async {
    try {
      onUpdate(status: Status.LOADING);
      logger.i(userData.toJson());
      logger.i(firebaseAuth.currentUser!.uid);
      await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).update(userData.toJson());
      getUserdata();
      onUpdate(status: Status.SCUSSESS);
    } catch (e) {
      onError(e, () {});
    }
  }

  String _verificationId = "";
  String phoneNumber = "";
  int? _resendToken;

  int remainingSeconds = 1;
  String time = '00.00';
  bool timerVisible = false;

  Future<void> phoneVerification(String number) async {
    try {
      phoneNumber = number;
      phoneVisible = true;
      _sendOTP(number);
    } catch (e) {
      logger.e(e);
    }
  }

  _startTimer(int seconds) {
    remainingSeconds = seconds;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        time = "00:00";
        timerVisible = true;
      } else {
        timerVisible = false;
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
      update();
    });
  }

  Future<void> verifyOtp(String otp, String number, String countryCode) async {
    try {
      onUpdate(status: Status.LOADING);
      // if (FirebaseAuth.instance.currentUser != null) {
      //   isLoggedIn = true;
      // uid = FirebaseAuth.instance.currentUser!.uid;
      // }
      // firebaseAuth.signOut();q
      /*======================================================================*/
      // await firebaseAuth.currentUser!.linkWithCredential(cred).then((value) => logger.i(value)).catchError((e){logger.e(e);});
      // await firebaseAuth.createUserWithEmailAndPassword(
      //     email: dummyUserData.email, password: dummyUserData.password);
      /*======================================================================*/
      final credential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otp);
      logger.i(credential);
      // await FirebaseAuth.instance.signInWithCredential(credential);
      // logger.i(dummyUserData.toJson());
      // final cred = EmailAuthProvider.credential(
      //     email: dummyUserData.email, password: dummyUserData.password);
      // logger.i(firebaseAuth.currentUser!.uid);
      await firebaseAuth.currentUser!.updatePhoneNumber(credential);
      // await firebaseDb
      //     .collection("user_details")
      //     .doc(firebaseAuth.currentUser!.uid)
      //     .set(dummyUserData.toJson());
      await firebaseDb
          .collection("user_details")
          .doc(firebaseAuth.currentUser!.uid)
          .update({'phone_verified': true, 'phone': number, 'country_code': countryCode});
      /*======================================================================*/
      Get.back();
      getUserdata();
      onUpdate(status: Status.SCUSSESS);
      /*======================================================================*/
    } on FirebaseAuthException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(t);
      phoneDetermineError(e);
      // onError(e, () {});
    }
  }

  Future<void> _sendOTP(String number) async {
    try {
      onUpdate(status: Status.LOADING);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken,
      );
      // .onError((error, stackTrace) => logger.wtf(error, stackTrace));
    } on FirebaseAuthException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.wtf(t);
      Get.snackbar(e.code, "Invalid Check Phone Number",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.white);
    }
  }

  // int secondsRemaining = 30;
  // bool enableResend = false;
  // countDown(){}
  // Future<void> _resendOTP() async {
  //
  // }

  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    try {
      onUpdate(status: Status.SCUSSESS);
      logger.i("User Is LoggedIn");
      if (firebaseAuth.currentUser != null) {
        /*==========================================================*/
        logger.i("User Is LoggedIn");
        /*==========================================================*/
        // uid = FirebaseAuth.instance.currentUser!.uid;
      } else {
        logger.e("Failed to Sign In");
      }
    } catch (e, t) {
      logger.wtf(t);
      onError(e, () {});
    }
  }

  Future<void> verificationFailed(FirebaseAuthException exception) async {
    try {
      onUpdate(status: Status.SCUSSESS);
      logger.e(exception.message);
      logger.e(exception.code);
      phoneVisible = false;
      switch (exception.code) {
        case "too-many-requests":
          Get.snackbar("Too Many Requests", "Please Try again later",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
          break;
        case "network-request-failed":
          Get.snackbar("Please turn on Internet.", "Please Try again later",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
          break;
        case "account-exists-with-different-credential":
          Get.snackbar("Already In Use", "Account already link with another account",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
          break;
        default:
          Get.snackbar(phoneNumber, "Invalid...! Check Phone Number! / Already In Use",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
      }
    } catch (e, t) {
      logger.wtf(t);
      onError(e, () {});
    }
  }

  void codeSent(String verificationId, [int? resendToken]) {
    try {
      _verificationId = verificationId;
      _startTimer(120);
      phoneVisible = true;
      _resendToken = resendToken;
      // Get.toNamed(Routes.PHONE_VERIFICATION_SCREEN, arguments: phoneNumber);
      onUpdate(status: Status.SCUSSESS);
    } catch (e, t) {
      logger.wtf(t);
      onError(e, () {});
    }
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    try {
      onUpdate(status: Status.SCUSSESS);
      _verificationId = verificationId;
      // Get.snackbar(
      //   "Code Time-Out",
      //   "Something Went Wrong...!",
      //   icon: const Icon(Icons.person, color: AppColors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: AppColors.alertColor,
      // );
    } catch (e, t) {
      logger.wtf(t);

      onError(e, () {});
    }
  }

  Future<void> emailVerification(String password) async {
    try {
      onUpdate(status: Status.LOADING);
      final userCred = EmailAuthProvider.credential(email: firebaseAuth.currentUser!.email!, password: password);
      logger.i(firebaseAuth.currentUser!.email!);
      await firebaseAuth.currentUser!.reauthenticateWithCredential(userCred);
      emailVisible = true;
      onUpdate(status: Status.SCUSSESS);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Wrong password", "Make Sure Your Password is correct...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.white);
      onUpdate(status: Status.SCUSSESS);
      logger.e(e);
    }
  }

  Future<void> sendVerification(String email) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseAuth.currentUser!.updateEmail(email);
      firebaseAuth.currentUser!.email != email
          ? Get.snackbar("Successfully Email Changed $email", "Now Go to Verification",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              backgroundColor: AppColors.greenColor,
              colorText: AppColors.white)
          : null;
      await firebaseDb
          .collection("user_details")
          .doc(firebaseAuth.currentUser!.uid)
          .update({'email': email, 'email_verified': false});
      await firebaseAuth.currentUser!.sendEmailVerification();
      Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN_2, arguments: [email]);
      onUpdate(status: Status.SCUSSESS);
    } on FirebaseAuthException catch (e) {
      onUpdate(status: Status.SCUSSESS);
      switch (e.code) {
        case 'invalid-email':
          Get.snackbar("Invalid Email", "Please enter correct email address",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
          break;
        case 'email-already-in-use':
          Get.snackbar("Email is Already in Use", "Try Using Different Email",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
          break;
        default:
          Get.snackbar("Something Went Wrong...!", "Try again later...!",
              icon: const Icon(Icons.person, color: AppColors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.alertColor,
              shouldIconPulse: false,
              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              colorText: AppColors.white);
          break;
      }

      logger.e(e);
    }
  }

  Future<void> userEmailVerified(String password) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseAuth.currentUser!.reload();
      final userCred = EmailAuthProvider.credential(email: firebaseAuth.currentUser!.email!, password: password);
      logger.i(firebaseAuth.currentUser!.email!);
      await firebaseAuth.currentUser!.reauthenticateWithCredential(userCred);
      if (firebaseAuth.currentUser!.emailVerified) {
        logger.i("Verified");
        Get.snackbar(
          "User Successfully Verified",
          "",
          padding: const EdgeInsets.only(top: 25.0),
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.greenColor,
        );
        await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).update({'email_verified': true});
        Get.offAllNamed(Routes.HOME_PAGE);
        onUpdate(status: Status.SCUSSESS);
      } else {
        logger.i("Not Verified");
        Get.snackbar("Go to Email Box And Click on that link", "Sending from My Schedule App",
            icon: const Icon(Icons.person, color: AppColors.white),
            snackPosition: SnackPosition.BOTTOM,
            shouldIconPulse: false,
            margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            backgroundColor: AppColors.greyColor);
        await firebaseDb
            .collection("user_details")
            .doc(firebaseAuth.currentUser!.uid)
            .update({'email_verified': false});
        onUpdate(status: Status.SCUSSESS);
      }
    } on FirebaseAuthException catch (e) {
      onUpdate(status: Status.SCUSSESS);
      signInDetermineError(e);
      logger.e(e);
    }
  }

  Future<void> googleLinkCred() async {
    try {
      onUpdate(status: Status.LOADING);
      final googleSignIn = GoogleSignIn(scopes: <String>["email"], signInOption: SignInOption.standard);
      // Get.snackbar(
      //   "Please wait while data is loading",
      //   "Please Don't back",
      //   icon: const Icon(Icons.person, color: AppColors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      //   shouldIconPulse: false,
      //   backgroundColor: AppColors.amberColor,
      //   margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      // );
      final signInAccount = await googleSignIn.signIn();
      final googleAccountAuthentication = await signInAccount!.authentication;

      bool a = await firebaseDb
          .collection("user_details")
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((value) => UserData.fromJson(value.data() as Map<String, dynamic>))
          .then((value) => value.email == signInAccount.email);
      if (a) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAccountAuthentication.accessToken, idToken: googleAccountAuthentication.idToken);
        // await firebaseAuth.signInWithCredential(credential);
        await firebaseAuth.currentUser!.linkWithCredential(credential);
        await firebaseDb
            .collection("user_details")
            .doc(firebaseAuth.currentUser!.uid)
            .update({'google_sign': true, 'email_verified': true});
        Get.offAllNamed(Routes.HOME_PAGE);
      } else {
        await googleSignIn.signOut();
        Get.snackbar(
          "User already exist in another account",
          "Please link with different account",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          backgroundColor: AppColors.greyColor,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        );
      }
      onUpdate(status: Status.SCUSSESS);
    } catch (e) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(e);
      Get.snackbar(
        "You are not select any email id...!",
        "if you want login with google please select email..!",
        icon: const Icon(Icons.person, color: AppColors.black),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber.shade300,
        shouldIconPulse: false,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      );
    }
  }

  Future<void> facebookLinkCred() async {
    try {
      onUpdate(status: Status.LOADING);
      // Get.snackbar(
      //   "Please wait while data is loading",
      //   "Please Don't back",
      //   icon: const Icon(Icons.person, color: AppColors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: AppColors.amberColor,
      //   shouldIconPulse: false,
      //   margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      // );
      final LoginResult loginResult = await FacebookAuth.instance.login();
      var a = await FacebookAuth.instance.getUserData();
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String pretty = encoder.convert(a['email']);
      logger.i('Facebook Login User Id ==> ${pretty.replaceAll('"', '')}');

      bool b = await firebaseDb
          .collection("user_details")
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((value) => UserData.fromJson(value.data() as Map<String, dynamic>))
          .then((value) => value.email == pretty.replaceAll('"', ''));
      if (b) {
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
        // Once signed in, return the UserCredential
        await firebaseAuth.currentUser!.getIdToken();
        await firebaseAuth.currentUser!.linkWithCredential(facebookAuthCredential);
        await firebaseDb
            .collection("user_details")
            .doc(firebaseAuth.currentUser!.uid)
            .update({'facebook_sign': true, 'email_verified': true});
        Get.offAllNamed(Routes.HOME_PAGE);
      } else {
        Get.snackbar(
          "User already exist in another account",
          "Please link with current email ID",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.greyColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        );
      }
      onUpdate(status: Status.SCUSSESS);
    } catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(e);
      logger.e(t);
      Get.snackbar("Please wait while data is loading", "Please Don't back",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
    }
  }

  Future<void> logout() async {
    onUpdate(status: Status.LOADING);
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    onUpdate(status: Status.SCUSSESS);
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }
}
