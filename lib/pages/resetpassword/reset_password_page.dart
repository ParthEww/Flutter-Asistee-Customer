import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';

import '../../core/widgets/custom/custom_header_with_back_button.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                        CustomHeaderWithBackButton(
                          title: "Reset Password",
                          description:
                              "Don't worry, Just enter your Number\nand will send you the password recovery link",
                          isShowBackButton: true,
                          onBackButtonTap: (){ Get.back(); },
                        ),
                        const SizedBox(height: 60), // Spacer
                    
                        // New Password input field
                        CustomTextField(
                          customTextFieldType: CustomTextFieldType.PASSWORD,
                          textEditingController: controller.newPasswordController,
                          focusNode: controller.newPasswordFocusNode,
                          nextFocusNode: controller.confirmNewPasswordFocusNode,
                          hintText: "New Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          suffixIcon: Assets.images.svg.passwordCheck.path,
                        ),
                        const SizedBox(height: 18),
                        // Confirm New Password input field
                        CustomTextField(
                          customTextFieldType: CustomTextFieldType.PASSWORD,
                          textEditingController: controller.confirmNewPasswordController,
                          focusNode: controller.confirmNewPasswordFocusNode,
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
                        controller.onGoToLoginPage();
                      }, // TODO: Add sign in functionality
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
