library app;

///Dart
export 'dart:io' hide HeaderValue;
export 'dart:async';
export 'dart:convert';
export 'dart:math';

///Flutter
export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/services.dart';

///Theme & Styling
export './src/mics/app_style/app_colors.dart';
export './src/mics/app_style/theme.dart';

///Controller
export './src/module/auth/auth_controller.dart';
export './src/module/base_controller.dart';
export './src/module/main/home_controller.dart';
export './src/module/splash_screen/splash_controller.dart';
export './src/module/profile/profile_controller.dart';

///Service
export './src/service/app_service.dart';
export './src/service/pref_sevice.dart';

///Models
export './src/models/response_model.dart';
export './src/models/user_model.dart';
export './src/models/emuns.dart';
export './src/models/user_data.dart';
export './src/models/task_model.dart';

///Screen & View
export './src/module/auth/login_screen.dart';
export './src/module/auth/signup_screen.dart';
export './src/module/auth/forget_password.dart';
export './src/module/auth/verification.dart';
export './src/module/splash_screen/splash_screen.dart';
export './src/utils/widgets/loagin_view.dart';
export './src/utils/widgets/error_view.dart';
export './src/module/main/home_page.dart';
export 'src/module/profile/email_verification.dart';
export 'src/module/profile/email_verification_2.dart';
export 'src/module/profile/phone_verification.dart';
export './src/module/profile/profile_screen.dart';

///Plugins
export 'package:get/get.dart' hide FormData, MultipartFile, Response;
export 'package:get_storage/get_storage.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:device_info_plus/device_info_plus.dart';
export 'package:dio/dio.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'package:animated_text_kit/animated_text_kit.dart';
export 'package:country_picker/country_picker.dart';
export 'package:pinput/pinput.dart';
export 'package:file_picker/file_picker.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:animate_do/animate_do.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter_styled_toast/flutter_styled_toast.dart';
// export 'package:connectivity/connectivity.dart';

///Utils & Const
export './src/utils/const/key_const.dart';
export './src/utils/const/asset_const.dart';
export './src/utils/const/url_const.dart';
export './src/utils/const/firebase_auth_exception.dart';
export './src/utils/logger.dart';
export './src/mics/localization/localization.dart';

///Navigation
export './src/navigation/pages.dart';
export './src/navigation/routes.dart';
export './src/navigation/bindings.dart';
export './src/navigation/middelware.dart';

///Widgets
export './src/utils/widgets/list_tile_widget.dart';
export './src/utils/widgets/bottom_sheet.dart';
export './src/utils/widgets/text_field_box.dart';
export './src/utils/widgets/show_dialog.dart';
export './src/utils/widgets/profile_bottom_sheet.dart';
export './src/utils/widgets/disable_text_field.dart';

