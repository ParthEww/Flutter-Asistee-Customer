import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_structure/gen/assets.gen.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../../gen/fonts.gen.dart';
import '../../localization/app_strings.dart';
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
    /*switch (resource) {
      case Loading<T>(isLoadingShow: final isLoading):
        if (shouldShowLoader) {
          if (isLoading == true) {
            if (!Get.isDialogOpen!) {
              showLoaderDialog();
            }
          } else {
            if (Get.isDialogOpen!) {
              Get.back(closeOverlays: true); // Dismiss loader
            }
          }
        }
        break;

      case Success<T>(data: final data):
        onSuccess(data!);
        break;

      case Error<T>(message: final message):
        if (shouldShowErrorMessage) {
          Get.snackbar("Error", message ?? "Something went wrong");
        }
        onError?.call(message ?? "Something went wrong");
        break;

      case ErrorWithData<T>(data: _, message: final message):
        if (shouldShowErrorMessage) {
          Get.snackbar("Error", message ?? "Something went wrong");
        }
        onError?.call(message ?? "Something went wrong");
        break;

      case NoInternetError<T>(message: final message):
        showNoInternetBottomSheet(onNoInternet: onNoInternet);
        break;

      case AuthException<T>(message: final message):
        onAuthError?.call(message ?? "Session Expired");
        if (shouldShowErrorMessage) {
          Get.snackbar("Session Expired", message ?? "Please login again");
        }

        break;

      case ForceUpdate<T>(message: final message):
        if (shouldShowErrorMessage) {
          Get.snackbar("Update Required", message ?? "Please update the app");
        }
        onForceUpdate?.call();
        break;

      default:
        break;
    }*/
  });
}

//-------Loader dialog-------//
/*void showLoaderDialog() {
  Get.dialog(
    Center(child: Lottie.asset(
      Assets.animations.animLoader.path,
      width: 100,
      height: 100,
      repeat: true,
    )),
    barrierDismissible: false,
  );
}

//-------No internet dialog--------//
void showNoInternetBottomSheet({VoidCallback? onNoInternet}) {
  Get.bottomSheet(
      PopScope(
        canPop: false, // Prevent back press
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
              Text('Please check your internet and try again.',
                  textAlign: TextAlign.center, style: TextStyles.text14Medium),
              const SizedBox(height: 16),
              AppButton(
                buttonText: AppStrings.buttonRetry.tr,
                onPressed: () async {
                  if (await NetworkUtils.isConnectedToInternet()) {
                    onNoInternet?.call();
                  }
                },
                buttonRadius: 100,
                buttonHeight: 55,
                buttonColor: AppColors.primary,
                textColor: AppColors.white,
                textFontFamily: FontFamily.passengerSans,
                textFontSize: 16,
                textFontWeight: FontWeight.w700,
              )
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      isDismissible: false);
}*/
