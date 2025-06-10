import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/home_page.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/my_bookings_page.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/my_routes_page.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/settings_page.dart';
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

class DashboardController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;
  RxInt activeIndex = 0.obs;
  RxList<Widget> dashboardPageList = <Widget>[const HomePage(), const MyBookingsPage(), const MyRoutesPage(), const SettingsPage()].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onGoToOtpVerification() async {
    Get.toNamed(Routes.otpVerification);
  }

}
