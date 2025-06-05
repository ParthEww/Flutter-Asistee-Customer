import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../gen/assets.gen.dart';
import '../../localization/app_strings.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';

class DialogUtils {
  // alert dialog
  static void showAdaptiveAppDialog({
    required String message,
    required String titleStr,
    String? positiveText,
    String? negativeText,
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
  }) {
    Widget content = Text(
      message,
      style: TextStyles.text12Medium.copyWith(color: AppColors.black),
    );
    Widget title = Text(titleStr, style: TextStyles.text12Medium);
    final actions = <Widget>[
      if (negativeText != null) ...[
        TextButton(
          onPressed: () {
            Get.back();
            onNegativeTap!.call();
          },
          child: Text(
            negativeText,
            style: TextStyles.text12Medium.copyWith(color: AppColors.primary),
          ),
        ),
      ],
      TextButton(
        onPressed: () {
          Get.back();
          onPositiveTap!.call();
        },
        child: Text(
          positiveText!,
          style: TextStyles.text12Medium.copyWith(color: AppColors.primary),
        ),
      ),
    ];
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            return;
          },
          child: AlertDialog.adaptive(
            title: title,
            content: content,
            actions: actions,
          ),
        );
      },
    );
  }

  /// show error dialog
  static Future<void> showErrorDialog({
    bool isDismissible = false,
    bool backgroundBlur = true,
    required String dialogErrorMsg,
    void Function()? onClick,
  }) {
    return showAdaptiveDialog(
      context: Get.context!,
      barrierDismissible: isDismissible,
      builder: (context) {
        return PopScope(
          canPop: isDismissible,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: backgroundBlur ? 3 : 0,
              sigmaY: backgroundBlur ? 3 : 0,
            ),
            child: AlertDialog.adaptive(
              contentPadding: const EdgeInsets.only(
                top: 24,
                bottom: 16,
                left: 24,
                right: 24,
              ),
              content: Text(
                dialogErrorMsg,
                style: TextStyles.text12Medium,
                maxLines: 5,
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    if (onClick != null) {
                      onClick.call();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    AppStrings.okay.tr,
                    style: TextStyles.text12Medium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// snackbar
  static void showSnackBar(
    String message, {
    SnackbarType snackbarType = SnackbarType.success,
    void Function()? onErrorDialogClick,
  }) async {
    // if (!Get.isSnackbarOpen) {
    if (snackbarType == SnackbarType.errorDialog) {
      showErrorDialog(
        dialogErrorMsg: message,
        onClick: () {
          if (onErrorDialogClick != null) {
            onErrorDialogClick.call();
          } else {
            Navigator.pop(Get.context!);
          }
        },
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        messageText: Text(
          message,
          style: TextStyles.text12Medium.copyWith(color: AppColors.white),
        ),
        titleText: Container(),
        borderWidth: 1,
        backgroundColor: snackbarType == SnackbarType.success
            ? AppColors.success
            : AppColors.warning,
        colorText: Theme.of(Get.context!).colorScheme.surface,
        isDismissible: true,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        mainButton: TextButton(
          child: snackbarType == SnackbarType.success
              ? const Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
          onPressed: () {
            if (Get.isSnackbarOpen) {
              Get.closeCurrentSnackbar();
            }
          },
        ),
      );
    }
    // }
  }

  /// Shows a customizable bottom sheet for image/ file selection (Camera, Gallery, or Files).
  ///
  /// [context] - The BuildContext to show the bottom sheet.
  /// [imagePickerType] - Determines if only photos (PHOTOS) or photos + files (FILE_AND_PHOTOS) are allowed.
  static void showImagePickerSheet(BuildContext context,
      {ImagePickerType imagePickerType = ImagePickerType.PHOTOS}) {

    // ======================
    // Helper Widget: Builds a clickable option card (Camera/Gallery/File)
    // ======================
    Widget buildOption(String icon, String text, VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.lightMint,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Column(
            children: [
              SvgPicture.asset(icon, fit: BoxFit.none), // Icon (SVG)
              const SizedBox(height: 14),
              Text(
                text,
                style: TextStyles.text12Regular.copyWith(
                  color: AppColors.deepNavy.withOpacityPrecise(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ======================
    // Bottom Sheet Implementation
    // ======================
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Transparent background for overlay effect
      isScrollControlled: true, // Allows dynamic height
      enableDrag: false,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor, // Uses theme background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Fits content height
              children: [
                // ======================
                // Header Section (Title + Icon)
                // ======================
                Row(
                  children: [
                    // Circular Icon Container
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.deepNavy,
                      ),
                      child: SvgPicture.asset(
                        Assets.images.svg.uploadImageDialog.path,
                        fit: BoxFit.none,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title Text
                    Text(
                      "Select Option to Upload",
                      style: TextStyles.text14SemiBold,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ======================
                // Options Grid (Camera/Gallery/File)
                // ======================
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Camera Option
                    Expanded(
                      child: buildOption(
                        Assets.images.svg.camera.path,
                        "Camera",
                            () {
                          Navigator.pop(context);
                          // TODO: Handle camera selection logic
                        },
                      ),
                    ),
                    const SizedBox(width: 9),

                    // Gallery Option
                    Expanded(
                      child: buildOption(
                        Assets.images.svg.gallery.path,
                        "Gallery",
                            () {
                          Navigator.pop(context);
                          // TODO: Handle gallery selection logic
                        },
                      ),
                    ),

                    // File Option (Conditional)
                    if (imagePickerType == ImagePickerType.FILE_AND_PHOTOS) ...[
                      const SizedBox(width: 9),
                      Expanded(
                        child: buildOption(
                          Assets.images.svg.file.path,
                          "Files",
                              () {
                            Navigator.pop(context);
                            // TODO: Handle file selection logic
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

enum SnackbarType {
  success,
  failure,
  errorDialog,
}

enum ImagePickerType { PHOTOS, FILE_AND_PHOTOS }
