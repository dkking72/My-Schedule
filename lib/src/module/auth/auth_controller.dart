import "package:flutter/cupertino.dart";

import "../../../src_exports.dart";
import "package:intl/intl.dart";
import '../../plugin/date_picker.dart' as picker_date;

class AuthController extends BaseController{

  bool passwordVisible = true;

  onVisibilityChanged() {
    passwordVisible = !passwordVisible;
    onUpdate();
  }

  final TextEditingController birthdayCtrl = TextEditingController();
  DateTime? birthdayDateTime;

  onDate() async {
    DateTime? pickedDate = await picker_date.showDatePicker(
        context: Get.context!,
        initialDate: birthdayDateTime == null ? DateTime(1990) : birthdayDateTime!,
        firstDate: DateTime(1950),
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
    onUpdate();
  }

  var country = "91";

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
        country = e.phoneCode;
        logger.i('Select countryCode: $country');
        onUpdate();
      },
    );
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAllNamed(Routes.HOME_PAGE);
        onUpdate(status: Status.SCUSSESS);
      }
    } on FirebaseAuthException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.wtf(t);
      signInDetermineError(e);
    }
  }

  bool signUpBool = false;
  String phoneNumber = "";

  Future<void> signUp({required UserData userData}) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseAuth.createUserWithEmailAndPassword(email: userData.email, password: userData.password);
      await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).set(userData.toJson());
      Get.offAllNamed(Routes.VERIFICATION, arguments: [userData]);
      onUpdate(status: Status.SCUSSESS);
    } on FirebaseAuthException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.wtf(t);
      signUpDetermineError(e);
    }
  }

  // String uid = "";
  String _verificationId = "";
  int? _resendToken;

  int remainingSeconds = 1;
  String time = '00.00';
  bool timerVisible = false;

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

  Future<void> verifyOtp(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otp);
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
      logger.i(firebaseAuth.currentUser!.uid);
      // await FirebaseAuth.instance.signInWithCredential(credential);
      // logger.i(dummyUserData.toJson());
      // final cred = EmailAuthProvider.credential(
      //     email: dummyUserData.email, password: dummyUserData.password);
      // logger.i(firebaseAuth.currentUser!.uid);
      await firebaseAuth.currentUser!.linkWithCredential(credential).then((user) {
        logger.i(user);
      });
      // await firebaseDb
      //     .collection("user_details")
      //     .doc(firebaseAuth.currentUser!.uid)
      //     .set(dummyUserData.toJson());
      await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).update({'phone_verified': true});
      /*======================================================================*/

      Get.offAllNamed(Routes.HOME_PAGE);
      onUpdate(status: Status.SCUSSESS);
      /*======================================================================*/
    } on FirebaseAuthException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(t);
      phoneDetermineError(e);
      // onError(e, () {});
    }
  }

  Future<void> sendOTP({required String number}) async {
    try {
      onUpdate(status: Status.LOADING);
      logger.i('+$country $number');
      phoneNumber = number;
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+$country $number',
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken
      );
      // .onError((error, stackTrace) => logger.wtf(error, stackTrace));
    } on FirebaseAuthException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.wtf(t);
      Get.snackbar(
        e.code,
        "Invalid Check Phone Number",
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white
      );
    }
  }

  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    try {
      onUpdate(status: Status.SCUSSESS);
      logger.i("User Is LoggedIn");
      // await FirebaseAuth.instance.signInWithCredential(credential);

      if (FirebaseAuth.instance.currentUser != null) {
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
      Get.snackbar(
        '+$country $phoneNumber',
        "Invalid...! Check Phone Number! / Already In Use",
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          shouldIconPulse: false,
          colorText: AppColors.white
      );
    } catch (e, t) {
      logger.wtf(t);
      onError(e, () {});
    }
  }

  Future<void> codeSent(String verificationId, [int? resendToken]) async {
    try {
      _verificationId = verificationId;
      _startTimer(120);
      _resendToken = resendToken;
      signUpBool = true;
      await firebaseDb
          .collection("user_details")
          .doc(firebaseAuth.currentUser!.uid)
          .update({'phone': phoneNumber, 'country_code': '+$country'});
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

  Future<void> forgotPassword({required String email, BuildContext? context}) async {
    try {
      onUpdate(status: Status.LOADING);
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.back();
      Get.snackbar(
        email,
        "Please go to email and change your password",
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.greyColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white
      );
      onUpdate(status: Status.SCUSSESS);
    } catch (e) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(e);
      Get.snackbar(
        email,
        "Invalid email address / User not found",
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white
      );
    }
  }

  Future<void> googleSignIn() async {
    try {
      onUpdate(status: Status.LOADING);
      final googleSignIn = GoogleSignIn(scopes: <String>["email"], signInOption: SignInOption.standard);
      final signInAccount = await googleSignIn.signIn();
      final googleAccountAuthentication = await signInAccount!.authentication;
      // Get.snackbar(
      //   "Please wait while data is loading",
      //   "Please Don't back",
      //   icon: const Icon(Icons.person, color: AppColors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      //   shouldIconPulse: false,
      //   margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      //   backgroundColor: AppColors.amberColor,
      // );
      String a = signInAccount.email;
      logger.i('Google Login User Id ==> $a');
      // bool b = await firebaseDb.collection("user_details").get().then((e) => e.docs
      //     .map((e) {
      //       var model = UserData.fromJson(e.data());
      //       model.docId = e.id;
      //       return model;
      //     })
      //     .toList()
      //     .where((e) => e.email == a)
      //     .map((e) {
      //       return e.facebookSign || e.googleSign;
      //     })
      //     .toList()
      //     .contains(true));
      // logger.i(b);
      // if (b) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAccountAuthentication.accessToken, idToken: googleAccountAuthentication.idToken);
        await firebaseAuth.signInWithCredential(credential);
        bool abc = await FirebaseFirestore.instance
            .collection("user_details")
            .get()
            .then((e) => e.docs.map((e) => e.id).toList().contains(firebaseAuth.currentUser!.uid));
        logger.i(a);
        if (!abc) {
          await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).set({
            'fName': firebaseAuth.currentUser!.displayName!.split(" ").first,
            'lName': firebaseAuth.currentUser!.displayName!.split(" ").last,
            'phone': firebaseAuth.currentUser!.phoneNumber,
            'profile_img': firebaseAuth.currentUser!.photoURL,
            'email': firebaseAuth.currentUser!.email,
            'email_verified': true,
            'google_sign': true
          }, SetOptions(merge: true));
        }else{
          await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).update({
            'email_verified': true,
            'google_sign': true
          });
        }
        Get.offAllNamed(Routes.HOME_PAGE);
      // } else {
      //   await googleSignIn.signOut();
      //   Get.snackbar(
      //     "Please make sure your last time login id login in Google...!",
      //     "Otherwise please try again later...!",
      //     icon: const Icon(Icons.person, color: AppColors.white),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: AppColors.alertColor,
      //   );
      // }
      onUpdate(status: Status.SCUSSESS);
    } catch (e) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(e);
      Get.snackbar(
        "You are not select any email id...!",
        "if you want login with google please select email..!",
        icon: const Icon(Icons.person, color: AppColors.black),
        snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        backgroundColor: Colors.amber.shade300
      );
    }
  }

  Future<void> facebookSignIn() async {
    try {
      onUpdate(status: Status.LOADING);
      // Get.snackbar(
      //   "Please wait while data is loading",
      //   "Please Don't back",
      //   icon: const Icon(Icons.person, color: AppColors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      //   shouldIconPulse: false,
      //   margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      //   backgroundColor: AppColors.amberColor,
      // );
      final LoginResult loginResult = await FacebookAuth.instance.login();
      var a = await FacebookAuth.instance.getUserData();
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String pretty = encoder.convert(a['email']);
      logger.i('Facebook Login User Id ==> ${pretty.replaceAll('"', '')}');
      // bool b = await firebaseDb.collection("user_details").get().then((e) => e.docs
      //     .map((e) {
      //       var model = UserData.fromJson(e.data());
      //       model.docId = e.id;
      //       return model;
      //     })
      //     .toList()
      //     .where((e) => e.email == pretty.replaceAll('"', ''))
      //     .map((e) {
      //       return e.googleSign || e.facebookSign;
      //     })
      //     .toList()
      //     .contains(true));
      // logger.i(b);
      // if (b) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
        // Once signed in, return the UserCredential
        await firebaseAuth.signInWithCredential(facebookAuthCredential);
        bool abc = await FirebaseFirestore.instance
            .collection("user_details")
            .get()
            .then((e) => e.docs.map((e) => e.id).toList().contains(firebaseAuth.currentUser!.uid));
        if (!abc) {
          await firebaseDb.collection("user_details").doc(firebaseAuth.currentUser!.uid).set({
            'fName': firebaseAuth.currentUser!.displayName!.split(" ").first,
            'lName': firebaseAuth.currentUser!.displayName!.split(" ").last,
            'phone': firebaseAuth.currentUser!.phoneNumber,
            'profile_img': firebaseAuth.currentUser!.photoURL,
            'email': firebaseAuth.currentUser!.email,
            'email_verified': true,
            'facebook_sign': true
          }, SetOptions(merge: true));
        }
        Get.offAllNamed(Routes.HOME_PAGE);
      // } else {
      //   Get.snackbar(
      //     "Please make sure your last time login id login in facebook...!",
      //     "Otherwise please try again later...!",
      //     icon: const Icon(Icons.person, color: AppColors.white),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: AppColors.alertColor,
      //   );
      // }
      onUpdate(status: Status.SCUSSESS);
    } on FirebaseAuthMultiFactorException catch (e, t) {
      onUpdate(status: Status.SCUSSESS);
      logger.e(e);
      logger.e(t);
      Get.snackbar(
        "Please wait while data is loading",
        "Please Don't back",
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          colorText: AppColors.white
      );
    }
  }
}
