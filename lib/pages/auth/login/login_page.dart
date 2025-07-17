import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/text_styles.dart';
import '../../../core/widgets/app_text_field_label.dart';
import '../../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../../core/widgets/custom/custom_text_filed.dart';
import '../../../gen/assets.gen.dart';
import '../notifier/auth_notifier.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            // Top and bottom padding
            child: Column(
              children: [
                // Main content column with horizontal padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with back button and titles
                      const CustomAuthHeaderWithBackButton(
                        title: "Sign In",
                        description:
                            "Please provide us your basic details below\nand get into the system",
                      ),
                      const SizedBox(height: 80), // Spacer

                      // Email/Phone input field
                      CustomTextField(
                        customTextFieldType:
                            CustomTextFieldType.EMAIL_OR_PHONE_NUMBER,
                        textEditingController:
                            auth.emailOrPhoneNumberController!,
                        focusNode: auth.emailOrPhoneNumberFocusNode!,
                        nextFocusNode: auth.loginPasswordFocusNode,
                        // Moves to password field on next
                        hintText: "Email / Phone",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Assets.images.svg.email.path,
                      ),
                      const SizedBox(height: 18), // Spacer

                      // Password input field
                      CustomTextField(
                        customTextFieldType: CustomTextFieldType.PASSWORD,
                        textEditingController: auth.loginPasswordController!,
                        focusNode: auth.loginPasswordFocusNode!,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        suffixIcon: Assets.images.svg.passwordCheck.path,
                      ),
                      const SizedBox(height: 32), // Spacer

                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyles.text14Regular.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 74), // Large spacer

                // Bus image decoration
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    Assets.images.png.closeUpBus.path,
                    width: 70,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),

                // Bottom section with sign in button and registration link
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 46),
                      // Spacer

                      // Sign In button (implemented as a CustomTextField of type BUTTON)
                      CustomTextField(
                        customTextFieldType: CustomTextFieldType.BUTTON,
                        textEditingController: TextEditingController(),
                        focusNode: FocusNode(),
                        hintText: "Sign In",
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        suffixIcon: Assets.images.svg.arrowRightGreen.path,
                        onPressed: () {}, // TODO: Add sign in functionality
                      ),
                      const SizedBox(height: 28),
                      // Spacer

                      // Registration prompt
                      Center(
                        child: AppTextFieldLabel(
                          label: "New to Yay Ride?",
                          clickableLabel: "Register",
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
