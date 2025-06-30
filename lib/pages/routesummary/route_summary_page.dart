import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/app_methods.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/widgets/custom/custom_circle_icon.dart';
import 'route_summary_controller.dart';

enum RouteSummaryFlowType { NORMAL_FLOW, ROUTE_REQUEST_FLOW }

class RouteSummaryPage extends GetView<RouteSummaryController> {
  const RouteSummaryPage({super.key});

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
          title: "Route Summary",
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
            // Route details card
            _buildRouteDetailsCard(),
            const SizedBox(height: 12),
            // Booking type and calendar preview card
            _buildBookingTypeWithCalendarPreview(),
            const SizedBox(height: 36),
            Text(
              "By Adding new rule the existing Recurring rule will be removed and New rule will applied",
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

  /// Builds the route details section with white card
  Widget _buildRouteDetailsCard() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.white, width: 6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content padding
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with start and end locations
                _buildLocationRow(),
                const SizedBox(height: 7),
                // Timeline with route details
                _buildDetailsStack(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the row containing start and end locations with route icon
  Widget _buildLocationRow() {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Route icon
          Column(
            children: [
              CustomCircleIcon(
                iconPath: Assets.images.svg.route20.path,
                padding: const EdgeInsets.all(14),
                backgroundColor: AppColors.deepNavy,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start and end location with arrow
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "start Location",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.text16SemiBold
                            .copyWith(color: AppColors.deepNavy),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      Assets.images.svg.arrowRightGreen.path,
                      fit: BoxFit.none,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "end Location",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.text16SemiBold
                            .copyWith(color: AppColors.deepNavy),
                      ),
                    ),
                  ],
                ),
                // Via text (intermediate stops)
                Text(
                  "viaText",
                  style: TextStyles.text12Regular.copyWith(
                      color: AppColors.primary.withOpacityPrecise(0.6),
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          if ((Get.arguments as RouteSummaryFlowType) ==
              RouteSummaryFlowType.ROUTE_REQUEST_FLOW) ...[
            Column(
              children: [
                CustomCircleIcon(
                  iconPath: Assets.images.svg.editPen.path,
                  padding:
                  const EdgeInsets.only(left: 7, top: 7, right: 9, bottom: 9),
                  backgroundColor: AppColors.white,
                ),
              ],
            )
          ]
        ],
      ),
    );
  }

  /// Builds the vertical timeline with route details (date, time, repeat)
  Widget _buildDetailsStack() {
    return Stack(
      children: [
        // Vertical line decoration
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: SvgPicture.asset(Assets.images.svg.line1.path, height: 65),
        ),
        // Route details items
        Padding(
          padding: const EdgeInsets.only(left: 13, top: 13),
          child: Column(
            children: [
              // Date range
              _buildDetailRow(
                iconPath: Assets.images.svg.calendar.path,
                text: "dateRange",
                iconBgColor: AppColors.lightSkyBlue,
              ),
              const SizedBox(height: 4),
              // Time range
              _buildDetailRow(
                iconPath: Assets.images.svg.clock.path,
                text: "timeRange",
                iconBgColor: AppColors.lightSkyBlue,
              )
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a single detail row with icon and text
  Widget _buildDetailRow({
    required String iconPath,
    required String text,
    required Color iconBgColor,
  }) {
    return Row(
      children: [
        // Circular icon
        CustomCircleIcon(
          iconPath: iconPath,
          padding: const EdgeInsets.all(6),
          backgroundColor: iconBgColor,
        ),
        const SizedBox(width: 10),
        // Detail text
        Expanded(
          child: Text(
            text,
            style: TextStyles.text12SemiBold
                .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.6)),
          ),
        ),
      ],
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
                    ]))
              ],
            )),
        const SizedBox(height: 18),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleIcon(
                      iconPath: Assets.images.svg.calendar16.path,
                      padding: const EdgeInsets.all(8),
                      backgroundColor: AppColors.deepNavy,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Schedule Preview",
                        style: TextStyles.text14SemiBold
                            .copyWith(color: AppColors.deepNavy),
                      ),
                    ),
                    if ((Get.arguments as RouteSummaryFlowType) ==
                        RouteSummaryFlowType.ROUTE_REQUEST_FLOW) ...[
                      CustomCircleIcon(
                        iconPath: Assets.images.svg.editPenWhite.path,
                        padding: const EdgeInsets.only(
                            left: 7, top: 7, right: 9, bottom: 9),
                        backgroundColor: AppColors.primary,
                      )
                    ],
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
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (context, day) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                    iconPath:
                                        Assets.images.svg.arrowRight18.path,
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
                              selectedDay.day == day.day);
                      return Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.primary.withOpacityPrecise(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${day.day}",
                          style: isSelected
                              ? TextStyles.text14Regular
                                  .copyWith(color: AppColors.white)
                              : TextStyles.text14Regular
                                  .copyWith(color: AppColors.deepNavy),
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
            GestureDetector(
              onTap: () {
                controller.onGoToPromoCode();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11, horizontal: 18),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(82),
                          border:
                              Border.all(color: AppColors.primary, width: 1),
                        ),
                        child: Text(
                          "Apply Promo Code",
                          style: TextStyles.text14Regular.copyWith(
                              color:
                                  AppColors.deepNavy.withOpacityPrecise(0.4)),
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
              ),
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
      child: AppButton(
        onPressed: () {},
        buttonText: "Add New Rule",
        buttonRadius: 32,
        buttonColor: AppColors.deepNavy,
        textFontSize: 18,
        textFontFamily: FontFamily.passengerSans,
        textFontWeight: FontWeight.w600,
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
