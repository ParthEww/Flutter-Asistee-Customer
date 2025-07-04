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

class SplashController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;
  late double screenHeight;
  late double screenWidth;

  @override
  void onInit() {
    callInitApi();
    super.onInit();
  }

  void initScreenDimensions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }

  /// Init API call
  Future<void> callInitApi() async {
    try {
      // final response = await _remoteRepository.initApi();

      _checkAndRedirect(redirect: true);
    } catch (e) {
      logger.e("callInitApi: $e");
    }
  }

  Future<void> _checkAndRedirect({required bool redirect}) async {
    redirect ? _onRedirectScreen() : _handleAppStatus();
  }

  Future<void> _handleAppStatus() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final androidAppID = packageInfo.packageName;
    const iosAppID = Constants.iosAppStoreId;

    switch (appStatus) {
      case AppStatus.optionalUpdate:
        _showUpdateDialog(
          message: "initApiResponse!.message",
          appName: AppStrings.appName.tr,
          forceUpdate: false,
          androidAppID: androidAppID,
          iosAppID: iosAppID,
        );
        break;

      case AppStatus.forceUpdate:
        _showUpdateDialog(
          message: "initApiResponse!.message",
          appName: AppStrings.appName.tr,
          forceUpdate: true,
          androidAppID: androidAppID,
          iosAppID: iosAppID,
        );
        break;

      case AppStatus.maintenance:
        _showMaintenanceDialog(
          message: "initApiResponse!.message",
          appName: AppStrings.appName.tr,
        );
        break;

      case AppStatus.normal:
        _onRedirectScreen();
        break;
    }
  }

  /// Redirection
  Future<void> _onRedirectScreen() async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final showOnboarding =
            (await _localRepository.getData(LocalStorageKey.showOnboarding)) ??
                true;

        if (showOnboarding) {
          Get.offAllNamed(Routes.login);
        } else {
          // UserModel? userModel = await _localRepository.getUserModel();
          int? userModel;

          // todo: user not logged in
                }
      },
    );
  }

  void _showUpdateDialog({
    required String message,
    required String appName,
    required bool forceUpdate,
    required String androidAppID,
    required String iosAppID,
  }) {
    DialogUtils.showAdaptiveAppDialog(
      titleStr: appName,
      message: message,
      positiveText: AppStrings.upgrade.tr,
      onPositiveTap: () {
        redirectToStore(
          androidAppId: androidAppID,
          iOSAppId: iosAppID,
        );
      },
      onNegativeTap: () {
        _onRedirectScreen(); // skip update
      },
      negativeText: forceUpdate ? null : AppStrings.later.tr,
    );
  }

  void _showMaintenanceDialog({
    required String message,
    required String appName,
  }) {
    DialogUtils.showAdaptiveAppDialog(
      titleStr: appName,
      message: message,
      positiveText: AppStrings.okay.tr,
      onPositiveTap: () {
        Platform.isAndroid ? SystemNavigator.pop() : Get.back();
      },
    );
  }

  void redirectToStore({
    required String androidAppId,
    required String iOSAppId,
  }) async {
    final Uri storeUri = Uri.parse(
      Theme.of(Get.context!).platform == TargetPlatform.android
          ? "https://play.google.com/store/apps/details?id=$androidAppId"
          : "https://apps.apple.com/app/id$iOSAppId",
    );

    if (await canLaunchUrl(storeUri)) {
      await launchUrl(storeUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $storeUri';
    }
  }
}
