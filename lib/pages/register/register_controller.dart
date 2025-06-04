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

class RegisterController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;
  // ----- [full name] -----
  FocusNode fullNameFocusNode = FocusNode();
  final TextEditingController fullNameController = TextEditingController();
  // ----- [phone number] -----
  FocusNode phoneNumberFocusNode = FocusNode();
  final TextEditingController phoneNumberController = TextEditingController();
  // ----- [email] -----
  FocusNode emailFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  // ----- [password] -----
  FocusNode passwordFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  // ----- [national id] -----
  FocusNode nationalIdFocusNode = FocusNode();
  final TextEditingController nationalIdController = TextEditingController();
  // ----- [nationality] -----
  FocusNode nationalityFocusNode = FocusNode();
  final TextEditingController nationalityController = TextEditingController();
  // ----- [area] -----
  FocusNode areaFocusNode = FocusNode();
  final TextEditingController areaController = TextEditingController();

  RxBool isChecked = false.obs;
  RxBool isImagePickerSheetVisible = false.obs;
  final DraggableScrollableController imagePickerSheetController = DraggableScrollableController();

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

  void onGoToLogin() async {
    Get.offAllNamed(Routes.login);
  }

}
