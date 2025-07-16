import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api_constant.dart';
import '../../core/enum/app_status.dart';
import '../../core/themes/app_strings.dart';
import '../../core/utils/dialog_utils.dart';
import '../../routes/navigation_service.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> _checkAndRedirect({required bool redirect}) async {
    redirect ? _onRedirectScreen() : _handleAppStatus();
  }

  Future<void> _handleAppStatus() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final androidAppID = packageInfo.packageName;
    const iosAppID = Constants.iosAppStoreId;

    if (state.initDataModel != null) {
      switch (state.initDataModel?.appStatus) {
        case AppStatus.optionalUpdate:
          _showUpdateDialog(
            message: "initApiResponse!.message",
            appName: AppStrings.appName,
            forceUpdate: false,
            androidAppID: androidAppID,
            iosAppID: iosAppID,
          );
          break;

        case AppStatus.forceUpdate:
          _showUpdateDialog(
            message: "initApiResponse!.message",
            appName: AppStrings.appName,
            forceUpdate: true,
            androidAppID: androidAppID,
            iosAppID: iosAppID,
          );
          break;

        case AppStatus.maintenance:
          _showMaintenanceDialog(
            message: "initApiResponse!.message",
            appName: AppStrings.appName,
          );
          break;

        case AppStatus.normal:
          _onRedirectScreen();
          break;

        default:
          break;
      }
    }
  }

  /// Redirection
  Future<void> _onRedirectScreen() async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        /*final showOnboarding =
            (await _localRepository.getData(LocalStorageKey.showOnboarding)) ??
                true;

        if (showOnboarding) {
          // Get.offAllNamed(Routes.login);
        } else {
          // UserModel? userModel = await _localRepository.getUserModel();
          int? userModel;

          // todo: user not logged in
        }*/
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
      positiveText: AppStrings.upgrade,
      onPositiveTap: () {
        redirectToStore(
          androidAppId: androidAppID,
          iOSAppId: iosAppID,
        );
      },
      onNegativeTap: () {
        _onRedirectScreen(); // skip update
      },
      negativeText: forceUpdate ? null : AppStrings.later,
    );
  }

  void _showMaintenanceDialog({
    required String message,
    required String appName,
  }) {
    DialogUtils.showAdaptiveAppDialog(
      titleStr: appName,
      message: message,
      positiveText: AppStrings.okay,
      onPositiveTap: () {
        Platform.isAndroid ? SystemNavigator.pop() : NavigationService().pop();
      },
    );
  }

  void redirectToStore({
    required String androidAppId,
    required String iOSAppId,
  }) async {
    final Uri storeUri = Uri.parse(
      Theme.of(NavigationService.navigatorKey.currentState!.context).platform == TargetPlatform.android
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
