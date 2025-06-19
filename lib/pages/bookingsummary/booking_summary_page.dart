import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/app_methods.dart';
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
import 'package:table_calendar/table_calendar.dart';

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
      padding: const EdgeInsets.only(left: 24, top: 30, right: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Bus details card
            _buildBusDetailsCard(),
            const SizedBox(height: 18),
            // number of seat card
            _buildNumberOfSeatsCard(),
            const SizedBox(height: 18),
            // Booking type and calendar preview card
            _buildBookingTypeWithCalendarPreview(),
            const SizedBox(height: 18),
            // Promo code car
            _buildPromoCodeCard(),
            const SizedBox(height: 18),
            // Price detail card
            _buildPriceDetailCard(),
            const SizedBox(height: 36),
            Text(
              "The total booking amount will be deducted from your walled after completion of the Trip.",
              style: TextStyles.text12Regular.copyWith(
                  color: AppColors.primary.withOpacityPrecise(0.6),
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  /// Builds the bus details section with white card
  Widget _buildBusDetailsCard() {
    return Container(
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
                            color: AppColors.deepNavy.withOpacityPrecise(0.6)),
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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
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

  /// Build number of seats card
  Widget _buildNumberOfSeatsCard() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(left: 24, top: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.lightMint,
        borderRadius: BorderRadius.circular(82),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "No. of Seat",
            style: TextStyles.text16SemiBold,
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  Assets.images.svg.minus.path,
                  fit: BoxFit.none,
                ),
                Text(
                  "3",
                  style: TextStyles.text14SemiBold.copyWith(
                      color: AppColors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.white,
                      decorationStyle: TextDecorationStyle.solid),
                ),
                SvgPicture.asset(
                  Assets.images.svg.plus.path,
                  fit: BoxFit.none,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Build booking type and calendar preview view
  Widget _buildBookingTypeWithCalendarPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: Get.width,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.lightMint,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCircleIcon(
                  iconPath: Assets.images.svg.repeat22.path,
                  padding: const EdgeInsets.all(8.75),
                  backgroundColor: AppColors.deepNavy,
                ),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        "Weekly, Repeat after 2 weeks",
                        style: TextStyles.text14Medium,
                      ),
                      Text(
                        "On Monday, Wednesday, Thursday, Friday, Saturday, Sunday",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.text10Regular.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(0.6)),
                      )
                    ])),
                Transform.rotate(
                  angle: 0, // 0 or pi(180)
                  child: SvgPicture.asset(Assets.images.svg.arrowUp.path),
                )
              ],
            )),
        const SizedBox(height: 8),
        Container(
            width: Get.width,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.lightMint,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CustomCircleIcon(
                      iconPath: Assets.images.svg.calendar16.path,
                      padding: const EdgeInsets.all(8),
                      backgroundColor: AppColors.deepNavy,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Schedule Preview",
                      style: TextStyles.text14SemiBold
                          .copyWith(color: AppColors.deepNavy),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  headerVisible: true,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      headerPadding: EdgeInsets.only(bottom: 24)),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    isTodayHighlighted: false,
                  ),
                  rowHeight: 42,
                  calendarBuilders:
                      CalendarBuilders(
                        headerTitleBuilder: (context, day) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: Text(
                                AppMethods.convertDateTimeToString(
                                    day, AppMethods.FORMAT_MMMM_YYYY),
                                style: TextStyles.text14SemiBold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Row(
                              children: [
                                Transform.rotate(
                                  angle: pi, // 0 or pi(180)
                                  child: CustomCircleIcon(
                                    iconPath:
                                        Assets.images.svg.arrowRight18.path,
                                    padding: const EdgeInsets.all(7),
                                    backgroundColor: AppColors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                CustomCircleIcon(
                                  iconPath: Assets.images.svg.arrowRight18.path,
                                  padding: const EdgeInsets.all(7),
                                  backgroundColor: AppColors.white,
                                )
                              ],
                            ),
                          )
                        ]);
                  },
                        defaultBuilder: (context, day, focusedDay) {
                          // Compare dates without time components
                          final isSelected = controller.selectedDaysList.any(
                                  (selectedDay) =>
                              selectedDay.year == day.year &&
                                  selectedDay.month == day.month &&
                                  selectedDay.day == day.day
                          );
                          return Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.primary.withOpacityPrecise(0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                                "${day.day}",
                              style: isSelected ? TextStyles.text14Regular.copyWith(color: AppColors.white) : TextStyles.text14Regular.copyWith(color: AppColors.deepNavy),
                            ),
                          );
                        },
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyles.text12Medium.copyWith(
                          color: AppColors.primary.withOpacityPrecise(0.4)),
                      weekendStyle: TextStyles.text12Medium.copyWith(
                          color: AppColors.primary.withOpacityPrecise(0.4))),
                  onDaySelected: (selectedDay, focusedDay) {
                    print("day tap");
                  },
                )
              ],
            ))
      ],
    );
  }

  /// Build promo code card
  Widget _buildPromoCodeCard() {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CustomCircleIcon(
                  iconPath: Assets.images.svg.promoCode.path,
                  padding: const EdgeInsets.all(7),
                  backgroundColor: AppColors.deepNavy,
                ),
                const SizedBox(width: 12),
                Text(
                  "Promo Code",
                  style: TextStyles.text14SemiBold
                      .copyWith(color: AppColors.deepNavy),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 18),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(82),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Text(
                        "Apply Promo Code",
                        style: TextStyles.text14Regular.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(0.4)),
                      )),
                ),
                const SizedBox(width: 6),
                CustomCircleIcon(
                  iconPath: Assets.images.svg.arrowRight24.path,
                  padding: const EdgeInsets.all(9),
                  backgroundColor: AppColors.primary,
                ),
                /* const SizedBox(width: 12),
                        Text(
                          "Promo Code",
                          style: TextStyles.text14SemiBold.copyWith(color: AppColors.deepNavy),
                        ),*/
              ],
            )
          ],
        ));
  }

  /// Build price detail card
  Widget _buildPriceDetailCard() {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CustomCircleIcon(
                  iconPath: Assets.images.svg.money.path,
                  padding: const EdgeInsets.all(8),
                  backgroundColor: AppColors.deepNavy,
                ),
                const SizedBox(width: 12),
                Text(
                  "Price Details",
                  style: TextStyles.text14SemiBold
                      .copyWith(color: AppColors.deepNavy),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceBreakDown(PriceBreakDownType.BUS_FARE, "30"),
                const SizedBox(height: 10),
                _buildPriceBreakDown(
                    PriceBreakDownType.PROMO_CODE_DISCOUNT, "5"),
                const SizedBox(height: 10),
                _buildPriceBreakDown(PriceBreakDownType.TAX_AND_CHARGES, "5"),
                const SizedBox(height: 20),
                SizedBox(
                    width: Get.width,
                    child: SvgPicture.asset(Assets.images.svg.line5.path,
                        fit: BoxFit.fill)),
                const SizedBox(height: 20),
                _buildPriceBreakDown(PriceBreakDownType.TOTAL_PAY, "30"),
              ],
            )
          ],
        ));
  }

  /// Builds price detail break down row
  Widget _buildPriceBreakDown(
      PriceBreakDownType priceBreakDownType, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          priceBreakDownType.label,
          style: TextStyles.text14Regular
              .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.4)),
        ),
        Text(
          "${priceBreakDownType == PriceBreakDownType.PROMO_CODE_DISCOUNT ? "-" : ""}BD $price",
          style: switch (priceBreakDownType) {
            PriceBreakDownType.PROMO_CODE_DISCOUNT => TextStyles.text14Regular
                .copyWith(
                    color: AppColors.deepNavy, fontStyle: FontStyle.italic),
            PriceBreakDownType.TOTAL_PAY => TextStyles.text14SemiBold,
            _ => TextStyles.text14Regular.copyWith(color: AppColors.deepNavy),
          },
        ),
      ],
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
          controller.onGoToDashboard();
        },
      ),
    );
  }
}

/// enum for price break down
enum PriceBreakDownType {
  BUS_FARE("Bus Fare"),
  PROMO_CODE_DISCOUNT("Promo Code Discount"),
  TAX_AND_CHARGES("Tax & Charges"),
  TOTAL_PAY("Total Pay");

  final String label;

  const PriceBreakDownType(this.label);
}
