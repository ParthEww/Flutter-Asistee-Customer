import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/dialog_utils.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';

import '../../core/widgets/custom/custom_header_with_back_button.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
                    CustomHeaderWithBackButton(
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
                                  decoration: BoxDecoration(
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
                      textEditingController: controller.fullNameController,
                      focusNode: controller.fullNameFocusNode,
                      nextFocusNode: controller.phoneNumberFocusNode,
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
                      textEditingController: controller.phoneNumberController,
                      focusNode: controller.phoneNumberFocusNode,
                      nextFocusNode: controller.emailFocusNode,
                      // Moves to email field on next
                      hintText: "Phone Number",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.call.path,
                    ),
                    const SizedBox(height: 18),
                    // Email id input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.EMAIL,
                      textEditingController: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      nextFocusNode: controller.passwordFocusNode,
                      // Moves to password field on next
                      hintText: "Email ID",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.email.path,
                    ),
                    const SizedBox(height: 18),
                    // Password input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.PASSWORD,
                      textEditingController: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      nextFocusNode: controller.nationalIdFocusNode,
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
                      textEditingController: controller.nationalIdController,
                      focusNode: controller.nationalIdFocusNode,
                      nextFocusNode: controller.nationalityFocusNode,
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
                      textEditingController: controller.nationalityController,
                      focusNode: controller.nationalityFocusNode,
                      // Moves to area field on next
                      hintText: "Your Nationality",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Assets.images.svg.dropDownArrow.path,
                      onPressed: () {
                        CommonDropdownSelectionBottomSheet.showBottomSheet(
                            dialogType:
                                CommonDropdownSelectionBottomSheetDialogType
                                    .SELECT_NATIONALITY,
                            commonList: controller.nationalityList);
                      },
                    ),
                    const SizedBox(height: 18),
                    // Spacer
                    // Area input field
                    CustomTextField(
                      customTextFieldType: CustomTextFieldType.AREA,
                      textEditingController: controller.areaController,
                      focusNode: controller.areaFocusNode,
                      hintText: "Area",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      suffixIcon: Assets.images.svg.dropDownArrow.path,
                      onPressed: () {
                        CommonDropdownSelectionBottomSheet.showBottomSheet(
                            dialogType:
                            CommonDropdownSelectionBottomSheetDialogType
                                .SELECT_AREA,
                            commonList: controller.areaList);
                      },
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.isChecked.value =
                                    !controller.isChecked.value;
                              },
                              child: SvgPicture.asset(controller.isChecked.value
                                  ? Assets.images.svg.checkBoxChecked.path
                                  : Assets.images.svg.checkBoxUnchecked.path),
                            )),
                        const SizedBox(width: 12),
                        AppTextFieldLabel(
                          label: "I hereby accept All the",
                          clickableLabel: "Terms and Conditions",
                          onTap: () {},
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
                        label: "Already on Yay Ride?",
                        clickableLabel: "Sign In",
                        onTap: () {},
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
