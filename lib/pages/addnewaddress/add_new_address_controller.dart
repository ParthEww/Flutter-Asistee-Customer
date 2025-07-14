import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_structure/api/model/static/address_field.dart';
import 'package:project_structure/api/model/static/address_field.dart';
import 'package:project_structure/api/model/static/address_field.dart';
import 'package:project_structure/api/model/static/address_type.dart';
import 'package:project_structure/api/model/static/address_type.dart';
import 'package:project_structure/api/model/static/address_type.dart';
import 'package:project_structure/api/model/static/address_type.dart';
import 'package:project_structure/api/model/static/address_type.dart';
import 'package:project_structure/core/utils/app_methods.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:store_redirect/store_redirect.dart';

import '../../api/api_constant.dart';
import '../../api/model/dummy/dummy_cancellation_reason.dart';
import '../../core/enum/app_status.dart';
import '../../core/utils/app_logger.dart';

import '../../core/utils/dialog_utils.dart';
import '../../core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import '../../localization/app_strings.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';

class AddNewAddressController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;

  // ----- [description] -----
  FocusNode descriptionFocusNode = FocusNode();
  final TextEditingController descriptionController =
      TextEditingController();

  // ----- [building name] -----
  FocusNode buildingNameFocusNode = FocusNode();
  final TextEditingController buildingNameController =
      TextEditingController();

  // ----- [road number] -----
  FocusNode roadNumberFocusNode = FocusNode();
  final TextEditingController roadNumberController =
      TextEditingController();

  // ----- [block] -----
  FocusNode blockFocusNode = FocusNode();
  final TextEditingController blockController =
      TextEditingController();

  // ----- [additional info] -----
  FocusNode additionalInfoFocusNode = FocusNode();
  final TextEditingController additionalInfoController =
      TextEditingController();

  final RxBool hasLocationPermission = false.obs;
  final Rx<CameraPosition?> cameraPosition = Rx<CameraPosition?>(null);
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize values before building widgets
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Then check for permission
      checkLocationPermission();
    });
  }

  Future<void> checkLocationPermission() async {
    hasLocationPermission.value = await Permission.location.isGranted;
    // If not granted, request permission
    if (!hasLocationPermission.value) {
      currentLocation.value = LatLng(26.2233381, 50.5849251);
      cameraPosition.value = CameraPosition(
        target: currentLocation.value!,
        zoom: 15,
      );
      hasLocationPermission.value = await AppMethods.askPermission(
        permission: Permission.location,
        whichPermission: AppStrings.location.tr,
      );
    }
    if (hasLocationPermission.value) {
      final position = await Geolocator.getCurrentPosition();
      currentLocation.value = LatLng(position.latitude, position.longitude);
      cameraPosition.value = CameraPosition(
        target: currentLocation.value!,
        zoom: 15,
      );
      // If map controller is available, animate to new location
      if (mapController.value != null) {
        mapController.value!.animateCamera(
          CameraUpdate.newLatLng(currentLocation.value!),
        );
      }
    }
  }

  void onGoToOtpVerification() async {
    Get.toNamed(Routes.otpVerification);
  }

  final RxList<AddressType> addressTypeList = <AddressType>[
    AddressType(title: 'Home', image_path: Assets.images.svg.addressTypeHome.path),
    AddressType(title: 'Work', image_path: Assets.images.svg.addressTypeWork.path),
    AddressType(title: 'Other', image_path: Assets.images.svg.addressTypeOther.path),
    AddressType(title: 'Other 1', image_path: Assets.images.svg.addressTypeOther.path),
    AddressType(title: 'Other 2', image_path: Assets.images.svg.addressTypeOther.path),
    AddressType(title: 'Other 3', image_path: Assets.images.svg.addressTypeOther.path),
  ].obs;

  late final RxList<AddressField> addressFiledList = <AddressField>[
    AddressField(id: 0, hint: 'Description', icon: Assets.images.svg.addressFieldDescription.path, text: "", focusNode: descriptionFocusNode, textEditingController: descriptionController),
    AddressField(id: 1, hint: 'Building Name / Number', icon: Assets.images.svg.addressFieldBuildingName.path, text: "", focusNode: buildingNameFocusNode, textEditingController: buildingNameController),
    AddressField(id: 2, hint: 'Road Number', icon: Assets.images.svg.cpr.path, text: "", focusNode: roadNumberFocusNode, textEditingController: roadNumberController),
    AddressField(id: 3, hint: 'Block', icon: Assets.images.svg.addressFieldBlock.path, text: "", focusNode: blockFocusNode, textEditingController: blockController),
    AddressField(id: 4, hint: 'Additional Info', icon: Assets.images.svg.cpr.path, text: "", focusNode: additionalInfoFocusNode, textEditingController: additionalInfoController),
  ].obs;
}
