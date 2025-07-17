import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';
import 'package:flutter_yay_rider_driver/di/app_provider.dart';
import 'package:flutter_yay_rider_driver/routes/navigation_service.dart';
import 'package:pinput/pinput.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/text_styles.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/widgets/app_text_field_label.dart';
import '../../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../../core/widgets/custom/custom_text_filed.dart';
import '../../../gen/assets.gen.dart';
import '../notifier/auth_notifier.dart';

class OtpVerificationPage extends ConsumerWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final NavigationService navigationService = ref.read(navigationServiceProvider);
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Container(
          // Full screen container with background image
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                    navigationService.pop();
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
                          navigationService.pushReplacementNamed(AppRoutes.resetPassword)
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
        borderRadius: const BorderRadius.all(Radius.circular(82)),
      ),
    );
  }
}
