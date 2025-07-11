import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project_structure/api/model/request/loginRequest.dart';
import 'package:project_structure/api/model/response/userdata/user_data.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:store_redirect/store_redirect.dart';

import '../../api/api_constant.dart';
import '../../api/api_response.dart';
import '../../api/collect_resource_stream.dart';
import '../../api/model/response/init/init_data.dart';
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
  final TextEditingController emailOrPhoneNumberController =
      TextEditingController();

  // ----- [password] -----
  FocusNode passwordFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  /// Login API call
  void callLoginApi() {
    collectResourceStream<ApiResponse<UserData>>(
        stream: _remoteRepository.loginApi(LoginRequest(
            userName: emailOrPhoneNumberController.text.toString().trim(),
            password: passwordController.text.toString().trim(),
            deviceToken: '',
            deviceType: ApiConstant.deviceType)),
        shouldShowLoader: true,
        onSuccess: (apiResponse) {},
        onError: (message) {
          print("callLoginApi: onError - $message");
        },
        onNoInternet: () {
          callLoginApi();
        },
        onAuthError: (message) {
          print("callLoginApi: onAuthError - $message");
        });
  }

  void onGoToRegister() async {
    Get.toNamed(Routes.register);
  }

  void onGoToForgotPassword() async {
    Get.toNamed(Routes.forgotPassword);
  }

  void onGoToDashboard() async {
    Get.toNamed(Routes.dashboard);
  }
}
