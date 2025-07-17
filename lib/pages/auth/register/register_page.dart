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

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

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
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.only(left: 24, top: 40, right: 24, bottom: 20),
            // Top and bottom padding
            child: Column(
              children: [
                // Main content column with horizontal padding
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with back button and titles
                    const CustomAuthHeaderWithBackButton(
                      title: "Register",
                      description:
                      "Please provide us your basic details below\nand get into the system",
                    ),
                    const SizedBox(height: 40),
                    // Spacer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            DialogUtils.showImagePickerSheet(context);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                      Assets.images.svg.ellipseGradient.path)),
                              SvgPicture.asset(
                                  Assets.images.svg.ellipseDot.path),
                              SvgPicture.asset(
                                  Assets.images.svg.uploadImage.path)
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.images.svg.line2.path,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "Upload Profile",
                          style: TextStyles.text16SemiBold
                              .copyWith(color: AppColors.deepNavy),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Full name input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.FULL_NAME,
                      textEditingController: authState.fullNameController!,
                      focusNode: authState.fullNameFocusNode!,
                      nextFocusNode: authState.phoneNumberFocusNode!,
                      // Moves to phone number field on next
                      hintText: "Full Name",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.fullName.path,
                    ),
                    const SizedBox(height: 18),
                    // Phone number input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.PHONE_NUMBER,
                      textEditingController: authState.phoneNumberController!,
                      focusNode: authState.phoneNumberFocusNode!,
                      nextFocusNode: authState.emailFocusNode!,
                      // Moves to email field on next
                      hintText: "Phone Number",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.call.path,
                      onPressed: (){
                        /*authState.onGoToOtpVerification!();*/
                      },
                    ),
                    const SizedBox(height: 18),
                    // Email id input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.EMAIL,
                      textEditingController: authState.emailController!,
                      focusNode: authState.emailFocusNode!,
                      nextFocusNode: authState.registerPasswordFocusNode,
                      // Moves to password field on next
                      hintText: "Email ID",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.email.path,
                      onPressed: (){
                        /*authState.onGoToOtpVerification!();*/
                      },
                    ),
                    const SizedBox(height: 18),
                    // Password input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.PASSWORD,
                      textEditingController: authState.registerPasswordController!,
                      focusNode: authState.registerPasswordFocusNode!,
                      nextFocusNode: authState.nationalIdFocusNode!,
                      // Moves to national id field on next
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.passwordCheck.path,
                    ),
                    const SizedBox(height: 18),
                    // National id input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.NATIONAL_ID,
                      textEditingController: authState.nationalIdController!,
                      focusNode: authState.nationalIdFocusNode!,
                      nextFocusNode: authState.nationalityFocusNode!,
                      // Moves to nationality field on next
                      hintText: "National ID(CPR Number)",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.cpr.path,
                    ),
                    const SizedBox(height: 18),
                    // Spacer
                    // Nationality input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.NATIONALITY,
                      textEditingController: authState.nationalityController!,
                      focusNode: authState.nationalityFocusNode!,
                      // Moves to area field on next
                      hintText: "Your Nationality",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.dropDownArrow.path,
                      onPressed: () {
                        /*CommonDropdownSelectionBottomSheet.showBottomSheet(
                            dialogType:
                            CommonDropdownSelectionBottomSheetDialogType
                                .SELECT_NATIONALITY,
                            commonList: authState.nationalityList!);*/
                      },
                    ),
                    const SizedBox(height: 18),
                    // Spacer
                    // Area input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.AREA,
                      textEditingController: authState.areaController!,
                      focusNode: authState.areaFocusNode!,
                      hintText: "Area",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      suffixIcon: Assets.images.svg.dropDownArrow.path,
                      onPressed: () {
                        /*CommonDropdownSelectionBottomSheet.showBottomSheet(
                            dialogType:
                            CommonDropdownSelectionBottomSheetDialogType
                                .SELECT_AREA,
                            commonList: authState.areaList!);*/
                      },
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            authNotifier.toggleTermsAndCondition();
                          },
                          child: SvgPicture.asset(authState.isTermsAndConditionChecked!
                              ? Assets.images.svg.checkBoxChecked.path
                              : Assets.images.svg.checkBoxUnchecked.path),
                        ),
                        const SizedBox(width: 12),
                        AppTextFieldLabel(
                          label: "I hereby accept All the",
                          clickableLabel: "Terms and Conditions",
                          onTap: () {}, // TODO: Add terms and conditions functionality in web view screen
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Spacer
                    // Sign In button (implemented as a CustomTextField of type BUTTON)
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.BUTTON,
                      textEditingController: TextEditingController(),
                      focusNode: FocusNode(),
                      hintText: "Register",
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.done,
                      suffixIcon: Assets.images.svg.arrowRightGreen.path,
                      onPressed: () {
                        navigationService.pop();
                      }, // TODO: Add sign in functionality
                    ),
                    const SizedBox(height: 28),
                    // Spacer
                    // Registration prompt
                    Center(
                      child: AppTextFieldLabel(
                        label: "Already on Yay Ride?",
                        clickableLabel: "Sign In",
                        onTap: () {
                          navigationService.pop();
                        },
                      ),
                    ),
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
