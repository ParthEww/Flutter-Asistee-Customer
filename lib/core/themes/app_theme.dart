import 'package:flutter/material.dart';
import '../../constants/global.dart';
import '../../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static final appTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    canvasColor: AppColors.white,
    // textTheme: appTextTheme, // Use the light text theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: FontFamily.passengerSans,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        shadowColor: AppColors.transparent,
        elevation: 0,
        backgroundColor: AppColors.primary,
        // disabledBackgroundColor: AppColors.backgroundDisabled,
        foregroundColor: AppColors.white,
        // disabledForegroundColor: AppColors.backgroundNeutral400,
        minimumSize: const Size(double.infinity, Global.kButtonHeight),
      ),
    ),
    iconTheme: IconThemeData(
      size: 20, // Icon size for all icons
      color: AppColors.white, // Default icon color
    ),

    /// text field theme - light
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        top: 10,
        bottom: 10,
      ),
      labelStyle: TextStyles.text12Medium.copyWith(color: AppColors.black),
      floatingLabelStyle:
          TextStyles.text10Regular.copyWith(color: AppColors.gray100),
      errorStyle: TextStyles.text10Regular.copyWith(color: AppColors.warning),
      enabledBorder: _getFieldInputBorder(
        borderColor: AppColors.primary,
      ),
      focusedBorder: _getFieldInputBorder(
        borderColor: AppColors.primary,
      ),
      errorBorder: _getFieldInputBorder(borderColor: AppColors.warning),
      focusedErrorBorder: _getFieldInputBorder(borderColor: AppColors.warning),
      disabledBorder: _getFieldInputBorder(
        borderColor: AppColors.gray100,
      ),
    ),
  );

  // -----  -----
  static InputBorder _getFieldInputBorder({
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
