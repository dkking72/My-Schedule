import '../../../src_exports.dart';

signUpDetermineError(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      logger.wtf(e.code);
      Get.snackbar('invalid-email', "Please Enter Correct Email Address",
          icon: const Icon(Icons.person, color: AppColors.white),
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.white);
      break;
    case 'user-disabled':
      logger.wtf(e.code);
      Get.snackbar('user-disabled', "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          colorText: AppColors.white);
      break;
    case 'user-not-found':
      logger.wtf(e.code);
      Get.snackbar('user-not-found', "Are you new user?...Please go to sign up.",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          colorText: AppColors.white);
      break;
    case 'wrong-password':
      logger.wtf(e.code);
      Get.snackbar('wrong-password', "Please Enter Correct Password",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          colorText: AppColors.white);
      break;
    case 'email-already-in-use':
      logger.wtf(e.code);
      Get.snackbar('email-already-in-use', "Please Use Different Email to Sign Up",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case 'account-exists-with-different-credential':
      logger.wtf(e.code);
      Get.snackbar('account-exists-with-different-credential', "",
          padding: const EdgeInsets.only(top: 25.0),
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case 'invalid-credential':
      logger.wtf(e.code);
      Get.snackbar('invalid-credential', "Please Enter correct email / password",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case 'operation-not-allowed':
      logger.wtf(e.code);
      Get.snackbar('operation-not-allowed', "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case 'weak-password':
      logger.wtf(e.code);
      Get.snackbar('weak-password', "Please, Enter Strong password",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      logger.wtf(e.code);
      Get.snackbar('ERROR_MISSING_GOOGLE_AUTH_TOKEN', "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    default:
      logger.wtf(e.code);
      Get.snackbar(e.code, "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.white);
      break;
  }
}

signInDetermineError(FirebaseAuthException e) {
  logger.e(e);
  switch (e.code) {
    case "invalid-email":
      Get.snackbar("Your email address appears to be malformed.", "Enter Correct Email.",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.white);
      break;
    case "wrong-password":
      Get.snackbar("Your Email/password is wrong...!", "May be new User...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case "user-not-found":
      Get.snackbar("User with this email doesn't exist.", "",
          padding: const EdgeInsets.only(top: 25.0),
          icon: const Icon(Icons.person, color: AppColors.white),
          shouldIconPulse: false,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case "user-disabled":
      Get.snackbar("User with this email has been disabled.", "",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          padding: const EdgeInsets.only(top: 25.0),
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case "too-many-requests":
      Get.snackbar("Too many requests. Try again later.", "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    case "network-request-failed":
      Get.snackbar("No Internet Connection", "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
      break;
    default:
      Get.snackbar("An undefined Error happened...Try Again Later...!", "Something Went Wrong...!",
          icon: const Icon(Icons.person, color: AppColors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.alertColor,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          colorText: AppColors.white);
  }
}

phoneDetermineError(FirebaseAuthException e) {
  if ("credential-already-in-use" == e.code) {
    logger.wtf(e.code);
    Get.snackbar("This number is already used", "",
        padding: const EdgeInsets.only(top: 25.0),
        icon: const Icon(Icons.person, color: AppColors.white),
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
        shouldIconPulse: false,
        colorText: AppColors.white);
    // _sendError("This number is already used");
  } else if ("session-expired" == e.code) {
    logger.wtf(e.code);
    Get.snackbar("OTP expired please send again", "",
        padding: const EdgeInsets.only(top: 25.0),
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
        shouldIconPulse: false,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        colorText: AppColors.white);
    // _sendError("OTP expired please send again");
    throw Exception("OTP expired please send again");
  } else if ("invalid-verification-code" == e.code) {
    logger.wtf(e.code);
    Get.snackbar("Wrong otp please try again", "",
        padding: const EdgeInsets.only(top: 25.0),
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
        shouldIconPulse: false,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        colorText: AppColors.white);
    // _sendError("Wrong otp please try again" == e.code);
  } else {
    logger.wtf(e.code);
    Get.snackbar(e.code, "Something Went Wrong...!",
        icon: const Icon(Icons.person, color: AppColors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.alertColor,
        shouldIconPulse: false,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        colorText: AppColors.white);
  }
}
