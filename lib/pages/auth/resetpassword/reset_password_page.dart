import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yay_rider_driver/di/app_provider.dart';
import 'package:flutter_yay_rider_driver/routes/navigation_service.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/text_styles.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/widgets/app_text_field_label.dart';
import '../../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../../core/widgets/custom/custom_text_filed.dart';
import '../../../gen/assets.gen.dart';
import '../notifier/auth_notifier.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final NavigationService navigationService = ref.read(navigationServiceProvider);
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 40, right: 24, bottom: 20),
            // Top and bottom padding
            child: Column(
              children: [
                // Main content column with horizontal padding
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with back button and titles
                        CustomAuthHeaderWithBackButton(
                          title: "Reset Password",
                          description:
                          "Don't worry, Just enter your Number\nand will send you the password recovery link",
                          isShowBackButton: true,
                          onBackButtonTap: (){ navigationService.pop(); },
                        ),
                        const SizedBox(height: 60), // Spacer

                        // New Password input field
                        CustomTextField(
                          customTextFieldType: CustomTextFieldType.PASSWORD,
                          textEditingController: authState.newPasswordController!,
                          focusNode: authState.newPasswordFocusNode!,
                          nextFocusNode: authState.confirmNewPasswordFocusNode,
                          hintText: "New Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          suffixIcon: Assets.images.svg.passwordCheck.path,
                        ),
                        const SizedBox(height: 18),
                        // Confirm New Password input field
                        CustomTextField(
                          customTextFieldType: CustomTextFieldType.PASSWORD,
                          textEditingController: authState.confirmNewPasswordController!,
                          focusNode: authState.confirmNewPasswordFocusNode!,
                          hintText: "Confirm New Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          suffixIcon: Assets.images.svg.passwordCheck.path,
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom section with sign in button and registration link
                Column(
                  children: [
                    // Sign In button (implemented as a CustomTextField of type BUTTON)
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.BUTTON,
                      textEditingController: TextEditingController(),
                      focusNode: FocusNode(),
                      hintText: "Submit",
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: Assets.images.svg.arrowRightGreen.path,
                      onPressed: () {
                        navigationService.pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
