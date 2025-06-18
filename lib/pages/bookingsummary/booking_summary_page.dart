import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/app_text_field_required_label.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';

import '../../api/model/static/address_type.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import 'booking_summary_controller.dart';

class BookingSummaryPage extends GetView<BookingSummaryController> {
  const BookingSummaryPage({super.key});

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

                // Submit button at bottom
                _buildSubmitButton(),
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
          title: "Booking Summary",
          isShowSubtitle: false,
          isShowBackButton: true,
          onBackButtonTap: () {
            Get.back();
          }),
    );
  }

  /// Builds the main scrollable content
  Widget _buildScrollableContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Bus details card
            _buildBusDetailsCard(),

            const SizedBox(height: 18),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(
                        left: 24, top: 8, right: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.lightMint,
                      borderRadius: BorderRadius.circular(82),
                    ))),
            // Seat selection card
            _buildSeatSelectionCard(),

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  /// Builds the bus details section with white card
  Widget _buildBusDetailsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.white, width: 6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bus info section
              // _buildBusInfoSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCircleIcon(
                        iconPath: Assets.images.svg.calendar.path,
                        padding: const EdgeInsets.all(6),
                        backgroundColor: AppColors.lightMint,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "4th July 2024",
                          style: TextStyles.text12SemiBold.copyWith(
                              color:
                                  AppColors.deepNavy.withOpacityPrecise(0.6)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(21)),
                        ),
                        child: Text(
                          "BD 30/-",
                          style: TextStyles.text12SemiBold,
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SvgPicture.asset(
                    width: Get.width, Assets.images.svg.line4.path),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manama",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.text18SemiBold
                                .copyWith(color: AppColors.deepNavy),
                          ),
                          Text(
                            "10:00 AM",
                            style: TextStyles.text12Regular
                                .copyWith(fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(Assets.images.svg.line3.path),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColors.lightBlue,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(51)),
                                    border: Border.all(
                                        color: AppColors.white, width: 1)),
                                child: Text(
                                  "2:30 Hrs",
                                  style: TextStyles.text12SemiBold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          SvgPicture.asset(Assets.images.svg.bus16.path)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Budaiya",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.text18SemiBold
                                .copyWith(color: AppColors.deepNavy),
                          ),
                          Text(
                            "12:30 PM",
                            style: TextStyles.text12Regular
                                .copyWith(fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacityPrecise(0.14),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "eCitaro eCitaro",
                          style: TextStyles.text18SemiBold
                              .copyWith(color: AppColors.deepNavy),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Blue, GLS BUS",
                          style: TextStyles.text12Medium,
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildBusNumberChip(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the bus information section
  Widget _buildBusInfoSection() {
    return Container(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "eCitaro eCitaro",
            style:
                TextStyles.text18SemiBold.copyWith(color: AppColors.deepNavy),
          ),
          const SizedBox(height: 4),
          Text(
            "Blue, GLS BUS",
            style: TextStyles.text12Medium,
          ),
          const SizedBox(height: 12),
          _buildBusNumberChip(),
        ],
      ),
    );
  }

  /// Builds the seats availability row
  Widget _buildSeatsAvailability() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSeatsView(
            title: "Available Seats",
            icon: Assets.images.svg.availableSeat.path,
            seatCount: "12",
          ),
          buildSeatsView(
            title: "Reserved Seats",
            icon: Assets.images.svg.reservedSeat.path,
            seatCount: "16",
          ),
        ],
      ),
    );
  }

  /// Builds the reservation notice text
  Widget _buildReservationNotice() {
    return Center(
      child: AppTextFieldRequiredLabel(
        label: "20 reservation required to Start the Trip",
        showRequiredMark: true,
      ),
    );
  }

  /// Builds the custom divider line
  Widget _buildDividerLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 12,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        Expanded(
          child: SvgPicture.asset(Assets.images.svg.line4.path),
        ),
        Transform.rotate(
          angle: pi,
          child: Container(
            width: 12,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the driver details section
  Widget _buildDriverDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              "Driver Details",
              style:
                  TextStyles.text14SemiBold.copyWith(color: AppColors.deepNavy),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.softBlueGray,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Driver avatar
                Container(
                  width: 70,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    Assets.images.png.dummyProfileImage.path,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 24),

                // Driver info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ibrahim Abbas",
                        style: TextStyles.text16Medium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Bahrain Public Transport",
                        style: TextStyles.text10Regular.copyWith(
                          color: AppColors.deepNavy.withOpacityPrecise(0.6),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Rating chip
                      Container(
                        padding: const EdgeInsets.only(
                            left: 4, top: 4, right: 6, bottom: 4),
                        decoration: BoxDecoration(
                          color: AppColors.lightMint,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.images.svg.smiley.path),
                            const SizedBox(width: 4),
                            Text(
                              "4.5",
                              style: TextStyles.text12SemiBold
                                  .copyWith(color: AppColors.deepNavy),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              color: AppColors.green,
                              height: 7,
                              width: 1,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "125 Review",
                              style: TextStyles.text12Regular.copyWith(
                                  color: AppColors.deepNavy
                                      .withOpacityPrecise(0.6)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the seat selection card
  Widget _buildSeatSelectionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.white, width: 6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepNavy,
                  ),
                  child: SvgPicture.asset(
                    Assets.images.svg.availableSeat.path,
                    fit: BoxFit.none,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Seat Selection",
                  style: TextStyles.text14SemiBold,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Multiple seats option
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacityPrecise(0.14),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Multiple Seats",
                    style: TextStyles.text12SemiBold,
                  ),
                  Obx(() => GestureDetector(
                        onTap: () {
                          controller.isChecked.value =
                              !controller.isChecked.value;
                        },
                        child: SvgPicture.asset(
                          controller.isChecked.value
                              ? Assets.images.svg.checkBoxChecked.path
                              : Assets.images.svg.checkBoxUnchecked.path,
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Helper text
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                "Check this box If In Case you are booking seats\nfor your guest too.",
                style: TextStyles.text12Regular.copyWith(
                  color: AppColors.primary.withOpacityPrecise(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the submit button
  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField(
        customTextFieldType: CustomTextFieldType.BUTTON,
        textEditingController: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Join Now",
        keyboardType: TextInputType.none,
        textInputAction: TextInputAction.done,
        suffixIcon: Assets.images.svg.arrowRightGreen.path,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  /// Helper widget for bus number chip
  Widget _buildBusNumberChip() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(left: 2, top: 2, right: 12, bottom: 2),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(66),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.white,
              child: SvgPicture.asset(Assets.images.svg.numberPlate.path),
            ),
            const SizedBox(width: 8),
            Text("GLS 001", style: TextStyles.text12SemiBold),
          ],
        ),
      ),
    );
  }

  /// Helper widget for route view
  Widget _buildRouteView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 4, right: 4, bottom: 4),
        decoration: BoxDecoration(
          color: AppColors.softBlueGray,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                "Zallaq",
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.text14SemiBold
                    .copyWith(color: AppColors.deepNavy),
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              Assets.images.svg.rightArrowBlue.path,
              fit: BoxFit.none,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Northern City",
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.text14SemiBold
                    .copyWith(color: AppColors.deepNavy),
              ),
            ),
            CustomCircleIcon(
              iconPath: Assets.images.svg.route16.path,
              padding: const EdgeInsets.all(8),
              backgroundColor: AppColors.deepNavy,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget for seats view
  Widget buildSeatsView({
    required String title,
    required String icon,
    required String seatCount,
  }) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 27),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyles.text12Regular.copyWith(
              color: AppColors.deepNavy.withOpacityPrecise(0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SvgPicture.asset(icon, fit: BoxFit.none),
              const SizedBox(width: 10),
              Container(
                color: AppColors.green,
                height: 10,
                width: 1,
              ),
              const SizedBox(width: 10),
              Text(
                seatCount,
                style: TextStyles.text16SemiBold
                    .copyWith(color: AppColors.deepNavy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
