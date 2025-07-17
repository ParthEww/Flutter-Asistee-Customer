import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/gen/assets.gen.dart';
import 'package:flutter_yay_rider_driver/routes/navigation_service.dart';
import 'package:lottie/lottie.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../core/utils/network_utils.dart';
import 'resource.dart'; // Import your updated Resource<T> file

typedef ResourceCallback<T> = void Function(T data);

void collectResourceStream<T>({
  required Stream<Resource<T>> stream,
  bool shouldShowLoader = true,
  bool shouldShowErrorMessage = true,
  required ResourceCallback<T> onSuccess,
  Function(String message)? onAuthError,
  VoidCallback? onForceUpdate,
  Function(String message)? onError,
  VoidCallback? onNoInternet,
}) {
  stream.listen((resource) {
    switch (resource) {
      case Loading<T>(isLoadingShow: final isLoading):
        if (shouldShowLoader) {
          if (isLoading == true) {
            showLoaderDialog();
          } else {
            hideLoaderDialog();
          }
        }
        break;

      case Success<T>(data: final data):
        onSuccess(data!);
        break;

      case Error<T>(message: final message):
        if (shouldShowErrorMessage) {
          showErrorSnackbar(
              title: "Error", message: message ?? "Something went wrong");
        }
        onError?.call(message ?? "Something went wrong");
        break;

      case ErrorWithData<T>(data: _, message: final message):
        if (shouldShowErrorMessage) {
          showErrorSnackbar(
              title: "Error", message: message ?? "Something went wrong");
        }
        onError?.call(message ?? "Something went wrong");
        break;

      case NoInternetError<T>(message: final message):
        showNoInternetBottomSheet(onNoInternet: onNoInternet);
        break;

      case AuthException<T>(message: final message):
        onAuthError?.call(message ?? "Session Expired");
        if (shouldShowErrorMessage) {
          showErrorSnackbar(
              title: "Session Expired",
              message: message ?? "Please login again");
        }

        break;

      case ForceUpdate<T>(message: final message):
        if (shouldShowErrorMessage) {
          showErrorSnackbar(
              title: "Update Required",
              message: message ?? "Please update the app");
        }
        onForceUpdate?.call();
        break;

      default:
        break;
    }
  });
}

//-------Loader dialog-------//
void showLoaderDialog() {
  showDialog(
    context: NavigationService.navigatorKey.currentState!.context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Lottie.asset(
        Assets.animations.animLoader.path,
        width: 100,
        height: 100,
        repeat: true,
      ),
    ),
  );
}

void hideLoaderDialog() {
  Navigator.of(NavigationService.navigatorKey.currentState!.context,
          rootNavigator: true)
      .pop();
}

//-------Enhanced Snackbar with Title-------//
void showErrorSnackbar({
  required String title,
  required String message,
  Color backgroundColor = Colors.red,
}) {
  ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
      .showSnackBar(
    SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(message),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

//-------No internet bottom sheet--------//
void showNoInternetBottomSheet({VoidCallback? onNoInternet}) {
  showModalBottomSheet(
    context: NavigationService.navigatorKey.currentState!.context,
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              'No Internet Connection',
              style: TextStyles.text18Bold,
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your internet and try again.',
              textAlign: TextAlign.center,
              style: TextStyles.text14Medium,
            ),
            const SizedBox(height: 16),
            AppButton(
              buttonText: 'Retry',
              onPressed: () async {
                if (await NetworkUtils.isConnectedToInternet()) {
                  Navigator.of(context).pop();
                  onNoInternet?.call();
                }
              },
              buttonRadius: 100,
              buttonHeight: 55,
              buttonColor: AppColors.primary,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    ),
  );
}
