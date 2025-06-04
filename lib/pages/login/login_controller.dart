import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:store_redirect/store_redirect.dart';

import '../../api/api_constant.dart';
import '../../core/enum/app_status.dart';
import '../../core/utils/app_logger.dart';

import '../../core/utils/dialog_utils.dart';
import '../../localization/app_strings.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;
  // ----- [phone number] -----
  FocusNode emailOrPhoneNumberFocusNode = FocusNode();
  final TextEditingController emailOrPhoneNumberController = TextEditingController();
  // ----- [password] -----
  FocusNode passwordFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    callLoginApi();
    super.onInit();
  }

  /// Init API call
  Future<void> callLoginApi() async {
    try {
      final response = await _remoteRepository.initApi();

    } catch (e) {
      logger.e("callInitApi: $e");
    }
  }

  void onGoToRegister() async {
    Get.offAllNamed(Routes.register);
  }

  void onGoToForgotPassword() async {
    Get.offAllNamed(Routes.forgotPassword);
  }
}
