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
import 'package:project_structure/core/widgets/custom/custom_back_button.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';

import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import 'edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
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
                          onPressed: (){
                            controller.onGoToOtpVerification();
                          },
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
                          onPressed: (){
                            controller.onGoToOtpVerification();
                          },
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
                      ],
                    )
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  customTextFieldType: CustomTextFieldType.BUTTON,
                  textEditingController: TextEditingController(),
                  focusNode: FocusNode(),
                  hintText: "Register",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: Assets.images.svg.arrowRightGreen.path,
                  onPressed: () {
                    Get.back();
                  }, // TODO: Add sign in functionality
                ),
              ),
            ]
        )
      ),
    );
  }

  Widget buildHeaderSection(){
    return Container(
      height: Get.height * 0.28,
      color: AppColors.white,
      child: Stack(
          children: [
            Positioned(
              top: 0,
              width: Get.width,
              height: Get.height * 0.28 * 0.6,
              child: Container(
                color: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(onBackButtonTap: Get.back),
                      Text(
                        "Edit Profile",
                        style: TextStyles.text18SemiBold.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                              color: AppColors.white,
                              width: 6
                          )
                      ),
                      child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Image.asset(
                            Assets.images.png.dummyProfileImage.path,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                              color: AppColors.white,
                              width: 6
                          )
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 4, top: 4, right: 12, bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCircleIcon(
                                iconPath: Assets.images.svg.editPen.path,
                                padding: const EdgeInsets.only(left: 7, top: 7, right: 9, bottom: 9),
                                backgroundColor: AppColors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Edit Photo",
                                style: TextStyles.text12SemiBold,
                              )
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }
}
