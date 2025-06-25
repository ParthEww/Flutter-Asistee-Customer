import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:store_redirect/store_redirect.dart';

import '../../api/api_constant.dart';
import '../../api/model/dummy/dummy_cancellation_reason.dart';
import '../../core/enum/app_status.dart';
import '../../core/utils/app_logger.dart';

import '../../core/utils/dialog_utils.dart';
import '../../localization/app_strings.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';

class RouteRequestController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;
  RxBool isChecked = false.obs;

  // ----- [route name] -----
  FocusNode routeNameFocusNode = FocusNode();
  final TextEditingController routeNameController = TextEditingController();

  // ----- [boarding point] -----
  FocusNode boardingPointFocusNode = FocusNode();
  final TextEditingController boardingPointController = TextEditingController();

  // ----- [dropOff point] -----
  FocusNode dropOffPointFocusNode = FocusNode();
  final TextEditingController dropOffPointController = TextEditingController();

  // ----- [start time] -----
  FocusNode startTimeFocusNode = FocusNode();
  final TextEditingController startTimeController = TextEditingController();

  final FixedExtentScrollController hourController = FixedExtentScrollController();
  List<String> hours = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
  RxInt selectedHourIndex = 0.obs;

  final RxList<DummyCancellationReason> nationalityList = <DummyCancellationReason>[
    DummyCancellationReason(id: '1', reasonName: "Afghan", isSelected: true),
    DummyCancellationReason(id: '2', reasonName: "Algerian"),
    DummyCancellationReason(id: '3', reasonName: "Angolan"),
    DummyCancellationReason(id: '4', reasonName: "Argentine"),
    DummyCancellationReason(id: '5', reasonName: "Austrian"),
    DummyCancellationReason(id: '6', reasonName: "Bangladeshi"),
    DummyCancellationReason(id: '7', reasonName: "Belgian"),
    DummyCancellationReason(id: '8', reasonName: "Brazilian"),
    DummyCancellationReason(id: '9', reasonName: "British"),
    DummyCancellationReason(id: '10', reasonName: "Bulgarian"),
    DummyCancellationReason(id: '11', reasonName: "Cameroonian"),
    DummyCancellationReason(id: '12', reasonName: "Canadian"),
    DummyCancellationReason(id: '13', reasonName: "Chilean"),
    DummyCancellationReason(id: '14', reasonName: "Chinese"),
    DummyCancellationReason(id: '15', reasonName: "Colombian"),
    DummyCancellationReason(id: '16', reasonName: "Croatian"),
    DummyCancellationReason(id: '17', reasonName: "Czech"),
    DummyCancellationReason(id: '18', reasonName: "Danish"),
    DummyCancellationReason(id: '19', reasonName: "Dutch"),
    DummyCancellationReason(id: '20', reasonName: "Egyptian"),
    DummyCancellationReason(id: '21', reasonName: "Ethiopian"),
    DummyCancellationReason(id: '22', reasonName: "Finnish"),
    DummyCancellationReason(id: '23', reasonName: "French"),
    DummyCancellationReason(id: '24', reasonName: "German"),
    DummyCancellationReason(id: '25', reasonName: "Greek"),
    DummyCancellationReason(id: '26', reasonName: "Hungarian"),
    DummyCancellationReason(id: '27', reasonName: "Indian"),
    DummyCancellationReason(id: '28', reasonName: "Indonesian"),
    DummyCancellationReason(id: '29', reasonName: "Iranian"),
    DummyCancellationReason(id: '30', reasonName: "Iraqi"),
    DummyCancellationReason(id: '31', reasonName: "Irish"),
    DummyCancellationReason(id: '32', reasonName: "Israeli"),
    DummyCancellationReason(id: '33', reasonName: "Italian"),
    DummyCancellationReason(id: '34', reasonName: "Japanese"),
    DummyCancellationReason(id: '35', reasonName: "Jordanian"),
    DummyCancellationReason(id: '36', reasonName: "Kenyan"),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onGoToPickupDropOfScreen() async {
    Get.toNamed(Routes.pickupDropOff);
  }

}
