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

import '../../core/utils/common_utils.dart';
import '../../core/utils/dialog_utils.dart';
import '../../localization/app_strings.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';
import '../dashboard/dashboard_controller.dart';

class PickupDropOffController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;
  RxBool isChecked = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize values before building widgets
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonUtils.activeTabBarBookingStatus.value = BookingStatusType.PICK_UP;
      CommonUtils.commonTabList = [
        BookingStatusType.PICK_UP,
        BookingStatusType.DROP_OFF
      ];
    });
  }

  /// Navigates to booking summary screen
  void onGoToBookingSummary() async {
    Get.toNamed(Routes.bookingSummary);
  }

}
