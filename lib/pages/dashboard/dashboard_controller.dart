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
import '../../api/model/response/route_data.dart';
import '../../api/model/response/route_stop.dart';
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

  // ----- [search] -----
  FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

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

  final RxList<RouteData> routeDataList = <RouteData>[
    RouteData(
      routeName: 'Morning Commute',
      routeNumber: 'RT-101',
      startTime: '08:00 AM',
      endTime: '09:30 AM',
      approxDuration: '1.5 hours',
      approxDistance: '25 km',
      routeStops: [
        RouteStop(
          stopName: 'Central Station',
          lat: '40.7128',
          lng: '-74.0060',
        ),
        RouteStop(
          stopName: 'Downtown Plaza',
          lat: '40.7145',
          lng: '-74.0082',
        ),
      ],
      isOnboard: false,
    ),
    RouteData(
      routeName: 'Evening Return',
      routeNumber: 'RT-102',
      startTime: '05:30 PM',
      endTime: '07:00 PM',
      approxDuration: '1.5 hours',
      approxDistance: '25 km',
      routeStops: [
        RouteStop(
          stopName: 'Downtown Plaza',
          lat: '40.7145',
          lng: '-74.0082',
        ),
        RouteStop(
          stopName: 'Central Station',
          lat: '40.7128',
          lng: '-74.0060',
        ),
      ],
      isOnboard: true,
    ),
  ].obs;

}
