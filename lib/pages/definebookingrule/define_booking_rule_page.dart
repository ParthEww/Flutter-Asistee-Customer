import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:project_structure/pages/routesummary/route_summary_controller.dart';

class DefineBookingRulePage extends GetView<RouteSummaryController> {
  const DefineBookingRulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Background with 30% primary color and 70% white
          _buildBackground(),

          // Main content with SafeArea
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                _buildAppBar(),

                // Scrollable content area
                Expanded(
                  child: _buildScrollableContent(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Builds the background with two colored sections
  Widget _buildBackground() {
    return Column(
      children: [
        Container(
          height: Get.height * 0.3,
          color: AppColors.primary,
        ),
        Expanded(
          child: Container(
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  /// Builds the custom app bar with back button and titles
  Widget _buildAppBar() {
    return Container(
      color: AppColors.primary,
      child: CustomHeader(
          title: "Route Request",
          isShowBackButton: true,
          onBackButtonTap: () {
            Get.back();
          }),
    );
  }

  /// Builds the main scrollable content
  Widget _buildScrollableContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 30, right: 24),
      child: _buildRequestNewRouteCard(),
    );
  }

  /// Builds the bus details section with white card
  Widget _buildRequestNewRouteCard() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.white, width: 6),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Request new route text
            Row(
              children: [
                Container(
                  width: 16,
                  height: 11,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.lightBlue.withOpacityPrecise(0.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Define Booking Rule",
                  style: TextStyles.text14SemiBold
                      .copyWith(color: AppColors.deepNavy),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      // Route name input field
                      CustomTextField(
                        customTextFieldType: CustomTextFieldType.FREQUENCY,
                        textEditingController: TextEditingController(),
                        focusNode: FocusNode(),
                        hintText: "Select Frequency",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        suffixIcon: Assets.images.svg.dropDownArrowWhite.path,
                        onPressed: () {
                          CommonDropdownSelectionBottomSheet.showBottomSheet(
                              dialogType:
                                  CommonDropdownSelectionBottomSheetDialogType
                                      .SELECT_FREQUENCY,
                              commonList: controller.frequencyList,
                              onTap: (dialogType, selectedItemIndex) {
                                controller.dialogType.value = dialogType;
                                controller.selectedItemIndex.value =
                                    selectedItemIndex;
                              });
                        },
                      ),
                      const SizedBox(height: 14),
                      // Boarding Point input field
                      CustomTextField(
                        customTextFieldType: CustomTextFieldType.REPEAT_AFTER,
                        textEditingController: TextEditingController(),
                        focusNode: FocusNode(),
                        hintText: "Repeat After Every",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Assets.images.svg.boardingPoint.path,
                      ),
                      const SizedBox(height: 14),
                      // Drop off Point input field
                      CustomTextField(
                        customTextFieldType: CustomTextFieldType.START_DATE,
                        textEditingController: TextEditingController(),
                        focusNode: FocusNode(),
                        hintText: "Start Date",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Assets.images.svg.calendar18.path,
                        onPressed: () {
                          CommonDropdownSelectionBottomSheet.showBottomSheet(
                              dialogType:
                                  CommonDropdownSelectionBottomSheetDialogType
                                      .START_DATE,
                              commonList: controller.frequencyList);
                        },
                      ),
                      const SizedBox(height: 14),
                      // start time input field
                      CustomTextField(
                        customTextFieldType: CustomTextFieldType.END_DATE,
                        textEditingController: TextEditingController(),
                        focusNode: FocusNode(),
                        hintText: "End Date",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Assets.images.svg.calendar18.path,
                        onPressed: () {
                          CommonDropdownSelectionBottomSheet.showBottomSheet(
                              dialogType:
                                  CommonDropdownSelectionBottomSheetDialogType
                                      .END_DATE,
                              commonList: controller.frequencyList);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppButton(
                onPressed: () {
                  if (controller.dialogType.value != null) {
                    if (controller.dialogType.value ==
                            CommonDropdownSelectionBottomSheetDialogType
                                .SELECT_FREQUENCY &&
                        controller.selectedItemIndex.value != -1) {
                      CommonDropdownSelectionBottomSheet.showBottomSheet(
                          dialogType:
                              CommonDropdownSelectionBottomSheetDialogType
                                  .DAYS_OF_THE_WEEK,
                          commonList: controller.daysOfTheWeekList,
                          onTap: (dialogType, selectedItemIndex) {
                            controller.dialogType.value = dialogType;
                            controller.selectedItemIndex.value =
                                selectedItemIndex;
                          });
                    } else if (controller.dialogType.value ==
                            CommonDropdownSelectionBottomSheetDialogType
                                .DAYS_OF_THE_WEEK &&
                        controller.selectedItemIndex.value != -1) {
                      CommonDropdownSelectionBottomSheet.showBottomSheet(
                          dialogType:
                              CommonDropdownSelectionBottomSheetDialogType
                                  .DAYS_DATES,
                          commonList: controller.daysOfTheWeekList,
                          onTap: (dialogType, selectedItemIndex) {
                            controller.dialogType.value = dialogType;
                            controller.selectedItemIndex.value =
                                selectedItemIndex;
                          });
                    }
                  } else {
                    controller.onGoToRouteSummary();
                  }
                },
                buttonText: "Next",
                buttonRadius: 82,
                buttonColor: AppColors.lightBlue,
                borderColor: AppColors.black,
                textFontSize: 16,
                textFontFamily: FontFamily.passengerSans,
                textFontWeight: FontWeight.w600,
                textColor: AppColors.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
