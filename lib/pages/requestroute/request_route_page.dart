import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/api/model/dummy/dummy_cancellation_reason.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/app_text_field_required_label.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/core/widgets/custom/custom_time_wheel_picker.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';

import '../../api/model/static/address_type.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import 'request_route_controller.dart';

class RequestRoutePage extends GetView<RequestRouteController> {
  const RequestRoutePage({super.key});

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
                  "Request New Route",
                  style: TextStyles.text14SemiBold
                      .copyWith(color: AppColors.deepNavy),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  // Route name input field
                  CustomTextField(
                    customTextFieldType: CustomTextFieldType.ROUTE_NAME,
                    textEditingController: controller.routeNameController,
                    focusNode: controller.routeNameFocusNode,
                    hintText: "Route Name",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    suffixIcon: Assets.images.svg.routeName.path,
                  ),
                  const SizedBox(height: 14),
                  // Boarding Point input field
                  CustomTextField(
                    customTextFieldType: CustomTextFieldType.BOARDING_POINT,
                    textEditingController: controller.boardingPointController,
                    focusNode: controller.boardingPointFocusNode,
                    hintText: "Boarding Point",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    suffixIcon: Assets.images.svg.boardingPoint.path,
                    onPressed: () {
                      CommonDropdownSelectionBottomSheet.showBottomSheet(
                          dialogType:
                          CommonDropdownSelectionBottomSheetDialogType
                              .SELECT_NATIONALITY,
                          commonList: controller.nationalityList);
                    },
                  ),
                  const SizedBox(height: 14),
                  // Drop off Point input field
                  CustomTextField(
                    customTextFieldType: CustomTextFieldType.DROPOFF_POINT,
                    textEditingController: controller.dropOffPointController,
                    focusNode: controller.dropOffPointFocusNode,
                    hintText: "Drop-Off Point",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    suffixIcon: Assets.images.svg.dropoffPoint.path,
                    onPressed: () {
                      CommonDropdownSelectionBottomSheet.showBottomSheet(
                          dialogType:
                          CommonDropdownSelectionBottomSheetDialogType
                              .SELECT_NATIONALITY,
                          commonList: controller.nationalityList);
                    },
                  ),
                  const SizedBox(height: 14),
                  // start time input field
                  CustomTextField(
                    customTextFieldType: CustomTextFieldType.START_TIME,
                    textEditingController: controller.startTimeController,
                    focusNode: controller.startTimeFocusNode,
                    hintText: "Start Time",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    suffixIcon: Assets.images.svg.clock18.path,
                    onPressed: () {
                      CommonDropdownSelectionBottomSheet.showBottomSheet(
                          dialogType:
                          CommonDropdownSelectionBottomSheetDialogType
                              .START_TIME,
                          commonList: controller.nationalityList);
                    },
                  ),
                ],
              ),
            ),
            // Display selected hour
            // Wheel picker
            // CustomTimeWheelPicker(wheelPickerType: WheelPickerType.HOUR),
            // CustomTimeWheelPicker(wheelPickerType: WheelPickerType.MINUTE),
            // CustomTimeWheelPicker(wheelPickerType: WheelPickerType.AM_PM),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppButton(
                onPressed: () {
                  controller.onGoToDefineRule();
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
