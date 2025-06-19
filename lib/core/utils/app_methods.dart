import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../localization/app_strings.dart';
import '../enum/language_code.dart';
import 'app_logger.dart';
import 'dialog_utils.dart';

class AppMethods {

  // Timezone constants
  static const String timeZoneUTC = "UTC";
  // static const String timeZoneUTC = "Asia/Tokyo";

  // Logging tag
  static const String _TAG = "DateTimeUtils";

  // Default format constants
  static const String DATEFORMAT = "yyyyMMddHHmmss";

  // Standard date formats
  static const String FORMAT_YYYY_MM_DD_T_HH_MM_SS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'";
  static const String FORMAT_EEE_MMM_dd_HH_mm_ss_zzz_yyyy = "EEE MMM dd HH:mm:ss zzz yyyy";
  static const String FORMAT_YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
  static const String FORMAT_HH_MM_A_DD_MMM_YY = "hh:mm a, dd MMM 'yy";
  static const String FORMAT_DD_MMM_YYYY_HH_MM_SS = "dd MMM yyyy, hh:mm:ss a";
  static const String FORMAT_YYYY_MM_DD = "yyyy-MM-dd";
  static const String FORMAT_DD_MM_YYYY = "dd/MM/yyyy";
  static const String FORMAT_EEEE = "EEEE";
  static const String FORMAT_DD_MMM_YYYY = "dd MMM yyyy";
  static const String FORMAT_MMMM_YYYY = "MMMM yyyy";
  static const String FORMAT_DD_MMM_YYYY_EEEE = "dd MMM yyyy, EEEE";
  static const String FORMAT_HH_MM = "HH:mm";
  static const String FORMAT_HH_MM_SS = "HH:mm:ss";
  static const String FORMAT_HH_MM_A = "hh:mm a";
  static const String FORMAT_HH = "hh"; // 12-hour format (e.g., 10)
  static const String FORMAT_MM = "mm"; // minutes (e.g., 30)
  static const String FORMAT_A = "a";   // AM/PM marker
  static const String FORMAT_D = "D";   // day of year

  // Ordinal date formats (1st, 2nd, 3rd, 4th, etc.)
  static const String FORMAT_MMMM_D_ST_YYYY = "MMMM d'st' yyyy";
  static const String FORMAT_MMMM_D_ND_YYYY = "MMMM d'nd' yyyy";
  static const String FORMAT_MMMM_D_RD_YYYY = "MMMM d'rd' yyyy";
  static const String FORMAT_MMMM_D_TH_YYYY = "MMMM d'th' yyyy";
  static const String FORMAT_D_ST_MMMM_YYYY = "d'st' MMMM yyyy";
  static const String FORMAT_D_ND_MMMM_YYYY = "d'nd' MMMM yyyy";
  static const String FORMAT_D_RD_MMMM_YYYY = "d'rd' MMMM yyyy";
  static const String FORMAT_D_TH_MMMM_YYYY = "d'th' MMMM yyyy";

  // Special pattern placeholders
  static const String MMMM_d_suffix_yyyy = "MMMM d_suffix yyyy"; // September 25th 2023
  static const String d_suffix_MMM_yyyy = "d_suffix MMM yyyy";
  static const String d_suffix_MMMM_yyyy = "d_suffix MMMM yyyy";
  static const String d_suffix = "d_suffix";

  // Compact date formats
  static const String MM_YY = "MM/yy";
  static const String YYYY = "yyyy";
  static const String DD_MMM = "dd MMM";

  /// `urlScheme`: "mailto" or "tel" (OPTIONAL)
  static Future<void> openLink({
    String urlPath = "",
    String urlScheme = "",
  }) async {
    Uri url;
    if (urlScheme != "") {
      url = Uri(scheme: urlScheme, path: urlPath);
    } else {
      if (urlPath.startsWith("http")) {
        url = Uri.parse(urlPath);
      } else {
        url = Uri.https(urlPath);
      }
    }

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // todo: show snackbar
      }
    } catch (e) {
      debugPrint("ERROR open link: $e");
    }
  }

  /// Get platform details
  static String getPlatformDevice() {
    if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isAndroid) {
      return "android";
    } else {
      return "unknown";
    }
  }

  /// Get converted date
  static String getConvertedDate({
    String? inputDateFormat,
    String? outputDateFormat = "yyyy-MM-dd",
    String? date,
  }) {
    if (date == null || date.isEmpty) {
      return "";
    }
    try {
      String locale = Get.locale?.languageCode ?? LanguageCode.en.name;

      DateTime inputDate = DateFormat(inputDateFormat, locale).parse(date);

      String dateFormat =
          DateFormat(outputDateFormat, locale).format(inputDate);
      return dateFormat;
    } catch (exception) {
      logger.e("getConvertedDate:$exception");
      return "";
    }
  }

  /// Get date in string format from Date Time value
  static String convertDateTimeToString(DateTime date, String format) {
    try {
      return DateFormat(format).format(date);
    } catch (e) {
      return 'Invalid date'; // Fallback for formatting errors
    }
  }

  /// android sdk version
  static Future<int> getAndroidVersion() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo =
          await DeviceInfoPlugin().androidInfo;
      logger.i(
        "androidDeviceInfo.version.sdkInt: ${androidDeviceInfo.version.sdkInt}",
      );
      return androidDeviceInfo.version.sdkInt;
    } else {
      return 0;
    }
  }

  /// permission
  static Future<bool> askPermission({
    Permission? permission,
    String? whichPermission,
  }) async {
    bool isPermissionGranted = await permission!.isGranted;
    var shouldShowRequestRationale =
        await permission.shouldShowRequestRationale;

    if (isPermissionGranted) {
      return true;
    } else {
      if (!shouldShowRequestRationale) {
        var permissionStatus = await permission.request();
        logger.e("STATUS == $permissionStatus");
        if (permissionStatus.isPermanentlyDenied) {
          DialogUtils.showAdaptiveAppDialog(
            titleStr: AppStrings.permission.tr,
            message:
                '${AppStrings.pleaseAllowThe.tr} $whichPermission ${AppStrings.permissionFromSettings.tr}',
            positiveText: AppStrings.settings.tr,
            onPositiveTap: () {
              openAppSettings();
            },
            negativeText: AppStrings.cancel.tr,
            onNegativeTap: () {},
          );
          return false;
        }
        if (permissionStatus.isGranted || permissionStatus.isLimited) {
          return true;
        } else {
          return false;
        }
      } else {
        var permissionStatus = await permission.request();
        if (permissionStatus.isGranted || permissionStatus.isLimited) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  /// Check image size
  static Future<bool> imageSize(XFile file) async {
    final bytes = (await file.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;

    logger.log("IMAGE SIZE ----$mb");

    if (mb <= 2) {
      return true;
    } else {
      return false;
    }
  }

  // Set status bar color
  static void updateStatusBar(Color backgroundColor) {
    // Calculate if background is dark
    final isDark = backgroundColor.computeLuminance() < 0.5;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
