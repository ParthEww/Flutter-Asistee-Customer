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

class CmsController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  RxBool isFaqExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onGoToPickupDropOfScreen() async {
    Get.toNamed(Routes.pickupDropOff);
  }

}
