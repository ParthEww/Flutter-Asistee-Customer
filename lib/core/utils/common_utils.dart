import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_methods.dart';

class CommonUtils {

  // Booking status tabs
  /*static Rx<BookingStatusType> activeTabBarBookingStatus =
      BookingStatusType.ONGOING.obs;*/

  // Tab lists
  // static late List<BookingStatusType> commonTabList;

  /*static final RxBool hasLocationPermission = false.obs;
  static final Rx<CameraPosition?> cameraPosition = Rx<CameraPosition?>(null);
  static final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  static final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);*/

  /*static Future<void> checkLocationPermission() async {
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
  }*/

  static Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

}