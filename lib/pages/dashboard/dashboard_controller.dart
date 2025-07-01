import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/home_page.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/my_bookings_page.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/my_routes_page.dart';
import 'package:project_structure/pages/dashboard/bottomscreen/settings_page.dart';
import 'package:project_structure/pages/tripdetail/trip_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:store_redirect/store_redirect.dart';

import '../../api/api_constant.dart';
import '../../api/model/response/route_data.dart';
import '../../api/model/response/route_stop.dart';
import '../../core/enum/app_status.dart';
import '../../core/utils/app_logger.dart';

import '../../core/utils/app_methods.dart';
import '../../core/utils/dialog_utils.dart';
import '../../gen/assets.gen.dart';
import '../../localization/app_strings.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';

/// Main controller for dashboard functionality
/// Handles navigation state, tab management, and data for dashboard screens
class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Dependencies
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  // Search functionality
  FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  // App state
  AppStatus appStatus = AppStatus.normal;

  // Navigation state
  Rx<BottomNavigationScreenType> activeBottomNavigationScreenType =
      BottomNavigationScreenType.HOME.obs;

  // Dashboard pages
  RxList<Widget> dashboardPageList = <Widget>[
    const HomePage(),
    const MyBookingsPage(),
    const MyRoutesPage(),
    const SettingsPage()
  ].obs;

  // Booking status tabs
  late Rx<BookingStatusType> activeTabBarBookingStatus =
      BookingStatusType.ONGOING.obs;

  // Tab lists
  late List<BookingStatusType> commonTabList;

  // Settings sections
  final List<SettingFieldType> firstSettingsList = [
    SettingFieldType.WALLET,
    SettingFieldType.ADMIN_CHAT,
    SettingFieldType.MY_ADDRESS,
    SettingFieldType.NOTIFICATIONS,
  ];

  final List<SettingFieldType> secondSettingsList = [
    SettingFieldType.ABOUT_US,
    SettingFieldType.CONTACT_US,
    SettingFieldType.FAQS,
    SettingFieldType.TERMS_AND_CONDITIONS,
    SettingFieldType.PRIVACY_POLICY,
  ];

  final List<SettingFieldType> thirdSettingsList = [
    SettingFieldType.LOGOUT,
    SettingFieldType.DELETE_ACCOUNT
  ];

  // Sample route data
  final RxList<RouteData> routeDataList = <RouteData>[
    RouteData(
      routeName: 'Morning Commute',
      routeNumber: 'RT-101',
      startTime: '08:00 AM',
      endTime: '09:30 AM',
      approxDuration: '1.5 hours',
      approxDistance: '25 km',
      requestType: "1",
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
      requestType: "2",
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

  final RxBool hasLocationPermission = false.obs;
  final Rx<CameraPosition?> cameraPosition = Rx<CameraPosition?>(null);
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);

  @override
  void onInit() {
    super.onInit();
    // Then check for permission
    checkLocationPermission();
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

  /// Navigates to edit profile screen
  void onGoToEditProfile() async {
    Get.toNamed(Routes.editProfile);
  }

  /// Navigates to trip detail screen
  void onGoToTripDetail() async {
    Get.toNamed(Routes.tripDetail,
        arguments: activeBottomNavigationScreenType.value ==
                BottomNavigationScreenType.HOME
            ? TripDetailFlowType.ROUTE_REQUEST_FLOW
            : TripDetailFlowType.NORMAL_FLOW);
  }

  /// Navigates to booking summary screen
  void onGoToBookingSummary() async {
    Get.toNamed(Routes.bookingSummary);
  }

  /// Navigates to route request screen
  void onGoToRouteRequest() async {
    Get.toNamed(Routes.requestRoute);
  }
}

/// Enum for bottom navigation tabs
enum BottomNavigationScreenType {
  HOME(page: 0),
  MY_BOOKINGS(page: 1),
  MY_ROUTES(page: 2),
  SETTINGS(page: 3);

  final int page;

  const BottomNavigationScreenType({required this.page});
}

/// Enum for route request types
enum RouteRequestType {
  ONE_TIME(id: "1", title: "One Time", isSelected: true),
  RECURRING(id: "2", title: "Recurring", isSelected: false);

  final String id;
  final String title;
  final bool isSelected;

  const RouteRequestType(
      {required this.id, required this.title, this.isSelected = false});
}

/// Represents different booking status types
class BookingStatusType {
  static final UPCOMING =
      BookingStatusType(id: 1, title: "Upcoming", apiStatus: "upcoming");

  static final ONGOING =
      BookingStatusType(id: 1, title: "Ongoing", apiStatus: "ongoing");

  static final COMPLETED =
      BookingStatusType(id: 1, title: "Completed", apiStatus: "completed");

  static final CANCELLED =
      BookingStatusType(id: 1, title: "Cancelled", apiStatus: "cancelled");

  static final PAST =
      BookingStatusType(id: 1, title: "Past", apiStatus: "completed");

  static final REQUEST_ROUTE = BookingStatusType(
      id: 1,
      title: "Request Route",
      apiStatus: "pending",
      icon: Assets.images.svg.add.path);

  static final PICK_UP = BookingStatusType(
      id: 1,
      title: "Pickup",
      apiStatus: "pickup",
      icon: Assets.images.svg.add.path);

  static final DROP_OFF = BookingStatusType(
      id: 1,
      title: "Drop-off",
      apiStatus: "drop-off",
      icon: Assets.images.svg.add.path);

  static final LIVE_TRACKING = BookingStatusType(
      id: 1,
      title: "Trip Started",
      apiStatus: "trip started",
      icon: Assets.images.svg.busPrimary18.path);

  final int id;
  final String title;
  final String apiStatus;
  final String? icon;

  const BookingStatusType({
    required this.id,
    required this.title,
    required this.apiStatus,
    this.icon,
  });
}

/// Represents different settings fields
class SettingFieldType {
  static final WALLET = SettingFieldType(
      icon: Assets.images.svg.settingsWallet.path, title: "Wallet");

  static final ADMIN_CHAT = SettingFieldType(
      icon: Assets.images.svg.settingsAdminChat.path, title: "Admin Chat");

  static final MY_ADDRESS = SettingFieldType(
      icon: Assets.images.svg.settingsMyAddress.path, title: "My Address");

  static final NOTIFICATIONS = SettingFieldType(
      icon: Assets.images.svg.settingsNotifications.path,
      title: "Notifications");

  static final ABOUT_US = SettingFieldType(
      icon: Assets.images.svg.settingsAboutUs.path, title: "About US");

  static final CONTACT_US = SettingFieldType(
      icon: Assets.images.svg.settingsContactUs.path, title: "Contact Us");

  static final FAQS = SettingFieldType(
      icon: Assets.images.svg.settingsFaqs.path, title: "FAQs");

  static final TERMS_AND_CONDITIONS = SettingFieldType(
      icon: Assets.images.svg.settingsTermsAndConditions.path,
      title: "Terms & Conditions");

  static final PRIVACY_POLICY = SettingFieldType(
      icon: Assets.images.svg.settingsPrivacyPolicy.path,
      title: "Privacy policy");

  static final LOGOUT = SettingFieldType(
      icon: Assets.images.svg.settingsLogout.path, title: "Logout");

  static final DELETE_ACCOUNT = SettingFieldType(
      icon: Assets.images.svg.settingsDeleteAccount.path,
      title: "Delete Account");

  final String icon;
  final String title;

  const SettingFieldType({
    required this.icon,
    required this.title,
  });
}
