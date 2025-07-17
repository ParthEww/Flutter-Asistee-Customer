import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yay_rider_driver/api/api_client/api_client.dart';
import 'package:flutter_yay_rider_driver/api/api_repository.dart';
import 'package:flutter_yay_rider_driver/api/api_response.dart';
import 'package:flutter_yay_rider_driver/api/collect_resource_stream.dart';
import 'package:flutter_yay_rider_driver/api/model/response/init/init_data.dart';
import 'package:flutter_yay_rider_driver/api/model/response/userdata/user_data.dart';
import 'package:flutter_yay_rider_driver/api/resource.dart';
import 'package:flutter_yay_rider_driver/di/app_provider.dart';
import 'package:flutter_yay_rider_driver/repository/local_repository/local_repository.dart';
import 'package:flutter_yay_rider_driver/routes/route_observer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/api_constant.dart';
import '../../../core/enum/app_status.dart';
import '../../../core/themes/app_strings.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../repository/remote_repository/remote_repository.dart';
import '../../../routes/navigation_service.dart';
import '../state/splash_state.dart';
part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  late final LocalRepository localRepository = ref.read(localRepositoryProvider);
  late final RemoteRepository remoteRepository = ref.read(remoteRepositoryProvider);
  @override
  SplashState build() {
    state = SplashState(
      // userData: await localRepository.getData(LocalStorageKey.userData)
    );
    initApi();
    return state;
  }

  void initApi() {
    collectResourceStream<ApiResponse<InitData>>(
        stream: remoteRepository.initApi(),
        shouldShowLoader: true,
        onSuccess: (apiResponse) {
          state = state.copyWith(initDataModel: apiResponse.jsonData);
          _handleAppStatus();
        },
        onError: (message) {
          print("callInitApi: onError - $message");
        },
        onNoInternet: () {
          initApi();
        },
        onAuthError: (message) {
          print("callInitApi: onAuthError - $message");
        });
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
        UserData? userData =
            await localRepository?.getData(LocalStorageKey.userData);
        if (userData != null) {
          NavigationService().pushNamed(AppRoutes.dashboard);
        } else {
          NavigationService().pushNamed(AppRoutes.login);
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
      Theme.of(NavigationService.navigatorKey.currentState!.context).platform ==
              TargetPlatform.android
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
