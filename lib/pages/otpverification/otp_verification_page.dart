import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/custom/custom_back_button.dart';
import 'package:project_structure/core/widgets/custom/custom_auth_header_with_back_button.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';

import 'otp_verification_controller.dart';

class OtpVerificationPage extends GetView<OtpVerificationController> {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // Full screen container with background image
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.webp.screenBg.path),
              fit: BoxFit
                  .cover, // Ensures image covers entire space while maintaining aspect ratio
            ),
          ),
          // Scrollable content area
          child: Container(
            padding:
                const EdgeInsets.only(left: 24, top: 40, right: 24, bottom: 20),
            // Top and bottom padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main content column with horizontal padding
                // Header with back button and titles
                CustomAuthHeaderWithBackButton(
                  title: "Verification",
                  description:
                      "Enter the 6 Digit OTP received on your\nregistered Email or Phone.",
                  isShowBackButton: true,
                  onBackButtonTap: () {
                    Get.back();
                  },
                ),
                const SizedBox(height: 60), // Spacer

                // Email/Phone input field
                Center(
                  child: Pinput(
                    length: 6,
                    // Number of pins
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    preFilledWidget: Text("-",
                        style: TextStyles.text16SemiBold.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(0.5))),
                    defaultPinTheme: _buildPinTheme(),
                    focusedPinTheme: _buildPinTheme(),
                    submittedPinTheme: _buildPinTheme().copyBorderWith(
                        border: Border.all(width: 0.5, color: AppColors.black)),
                    onCompleted: (pin) =>
                        controller.onGoToResetPassword()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static PinTheme _buildPinTheme() {
    return PinTheme(
      width: 50,
      height: 60,
      textStyle: TextStyles.text16SemiBold.copyWith(color: AppColors.deepNavy),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacityPrecise(0.3),
        border: Border.all(
            width: 0.5, color: AppColors.secondary.withOpacityPrecise(0.3)),
        borderRadius: BorderRadius.all(Radius.circular(82)),
      ),
    );
  }
}
