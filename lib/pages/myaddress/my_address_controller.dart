import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import 'package:project_structure/pages/routesummary/route_summary_page.dart';

import '../../api/model/dummy/dummy_cancellation_reason.dart';
import '../../core/enum/app_status.dart';
import '../../core/utils/app_methods.dart';
import '../../core/utils/common_utils.dart';
import '../../localization/app_strings.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';
import '../dashboard/dashboard_controller.dart';

class MyAddressController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;

  @override
  void onInit() {
    super.onInit();
  }

  void onGoToAddNewAddress() async {
    Get.toNamed(Routes.addNewAddress);
  }
}
