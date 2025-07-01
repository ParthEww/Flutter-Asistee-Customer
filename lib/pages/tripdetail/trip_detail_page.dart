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
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../api/model/static/address_type.dart';
import '../../core/utils/app_methods.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import '../bookingsummary/booking_summary_page.dart';
import 'trip_detail_controller.dart';

// Enum to define different flow types for the trip detail page
enum TripDetailFlowType { NORMAL_FLOW, ROUTE_REQUEST_FLOW }

// Main trip detail page widget
class TripDetailPage extends GetView<TripDetailController> {
  const TripDetailPage({super.key});

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

  /// Builds the background with two colored sections:
  /// - Top 30% with primary color
  /// - Bottom 70% with white color
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

  /// Builds the custom app bar with:
  /// - Back button
  /// - Title and subtitle
  Widget _buildAppBar() {
    return Container(
      color: AppColors.primary,
      child: CustomHeader(
          title: "Trip Details",
          subTitle: "Route no. 123456",
          isShowSubtitle: (Get.arguments as TripDetailFlowType) ==
              TripDetailFlowType.ROUTE_REQUEST_FLOW,
          isShowBackButton: true,
          onBackButtonTap: () {
            Get.back();
          }),
    );
  }

  /// Builds the main scrollable content area that changes based on flow type:
  /// - ROUTE_REQUEST_FLOW shows bus details and seat selection
  /// - NORMAL_FLOW shows upcoming/past trip details
  Widget _buildScrollableContent() {
    return Padding(
      padding: EdgeInsets.only(
          left: (Get.arguments as TripDetailFlowType) ==
              TripDetailFlowType.ROUTE_REQUEST_FLOW
              ? 0
              : 24,
          top: 30,
          right: (Get.arguments as TripDetailFlowType) ==
              TripDetailFlowType.ROUTE_REQUEST_FLOW
              ? 0
              : 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if ((Get.arguments as TripDetailFlowType) ==
                TripDetailFlowType.ROUTE_REQUEST_FLOW) ...[
              // Bus details card for route request flow
              _buildBusDetailsCard(),

              // Seat selection card for route request flow
              _buildSeatSelectionCard(),
            ] else ...[
              // Bus details card for upcoming/past trips
              _buildBusDetailsCardForUpcomingAndPastTrip(),
              const SizedBox(height: 16),

              // Booking type and calendar preview card
              _buildBookingTypeWithCalendarPreview(),
              const SizedBox(height: 16),

              // Driver details section
              _buildDriverDetail(),
              const SizedBox(height: 14),

              // Price detail card
              _buildPriceDetailCard(),
              const SizedBox(height: 12),

              // Booking amount notice text
              Text(
                "The total booking amount will be deducted from your walled after completion of the Trip.",
                style: TextStyles.text12Regular.copyWith(
                    color: AppColors.primary.withOpacityPrecise(0.6),
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),
            ]
          ],
        ),
      ),
    );
  }

  /// Builds the bus details card for ROUTE_REQUEST_FLOW with:
  /// - Bus information
  /// - Route view
  /// - Seats availability
  /// - Driver details
  Widget _buildBusDetailsCard() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.white, width: 6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 47, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bus info section
                  _buildBusInfoSection(),

                  const SizedBox(height: 40),

                  // Route view between locations
                  _buildRouteView(),

                  const SizedBox(height: 24),

                  // Seats availability information
                  _buildSeatsAvailability(),

                  const SizedBox(height: 16),

                  // Reservation notice text
                  _buildReservationNotice(),

                  const SizedBox(height: 16),

                  // Custom divider line
                  _buildDividerLine(),

                  const SizedBox(height: 18),

                  // Driver details section
                  _buildDriverDetails(),
                ],
              ),
            ),
          ),
        ),

        // Bus image overlay positioned at top-right
        Positioned(
          right: 0,
          top: 32,
          child: Image.asset(
            height: 116,
            Assets.images.png.busInTripDetail.path,
          ),
        )
      ],
    );
  }

  /// Builds the bus information section with:
  /// - Bus name
  /// - Bus type/color
  /// - Bus number chip
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

  /// Builds a custom decorative divider line with:
  /// - Curved ends
  /// - Dotted line in middle
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

  /// Builds the driver details section with:
  /// - Driver name and company
  /// - Driver avatar
  /// - Rating and reviews
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

  /// Builds the seat selection card with:
  /// - Header with icon
  /// - Multiple seats option toggle
  /// - Helper text
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
            // Header with icon
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

            // Multiple seats option toggle
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

            // Helper text explaining the option
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

  /// Builds the bus details card for upcoming/past trips with:
  /// - Trip date and price
  /// - Route with timings
  /// - Bus information
  Widget _buildBusDetailsCardForUpcomingAndPastTrip() {
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
            // Date and price row
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

            // Route divider line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SvgPicture.asset(
                  width: Get.width, Assets.images.svg.line4.path),
            ),
            const SizedBox(height: 32),

            // Route with locations and timings
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(Assets.images.svg.line3.path),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(51)),
                              border:
                              Border.all(color: AppColors.white, width: 1)),
                          child: Text(
                            "2:30 Hrs",
                            style: TextStyles.text12SemiBold,
                          ),
                        )
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
            const SizedBox(height: 32),

            // Seats availability information
            _buildSeatsAvailability(),
            const SizedBox(height: 16),

            // Reservation notice text
            _buildReservationNotice(),
            const SizedBox(height: 24),

            // Bus information at bottom
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

  /// Builds the seats availability row with:
  /// - Available seats count and icon
  /// - Reserved seats count and icon
  Widget _buildSeatsAvailability() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildSeatsView(
              title: "Available Seats",
              icon: Assets.images.svg.availableSeat.path,
              seatCount: "12",
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: buildSeatsView(
              title: "Reserved Seats",
              icon: Assets.images.svg.reservedSeat.path,
              seatCount: "16",
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the reservation notice text showing minimum reservations needed
  Widget _buildReservationNotice() {
    return Center(
      child: AppTextFieldRequiredLabel(
        label: "20 reservation required to Start the Trip",
        showRequiredMark: true,
        labelColor: AppColors.deepNavy.withOpacityPrecise(0.4),
      ),
    );
  }

  /// Builds the bus number chip with:
  /// - Number plate icon
  /// - Bus number text
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

  /// Helper widget to build a consistent seats view with:
  /// - Title
  /// - Icon
  /// - Seat count
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
            textAlign: TextAlign.center,
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

  /// Builds the route view between locations with:
  /// - Start location
  /// - Arrow icon
  /// - End location
  /// - Route icon button
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

  /// Builds the booking type and calendar preview section with:
  /// - Booking frequency information
  /// - Calendar preview of selected dates
  Widget _buildBookingTypeWithCalendarPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Booking frequency card
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

        // Calendar preview card
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
                // Header with icon
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

                // Table calendar widget
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

  /// Builds the driver detail card with:
  /// - Driver avatar
  /// - Driver name and company
  /// - Call button
  Widget _buildDriverDetail() {
    return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Driver avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  Assets.images.png.dummyProfileImage.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Driver info
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

            // Call button
            CustomCircleIcon(
              iconPath: Assets.images.svg.callBlack.path,
              padding: const EdgeInsets.all(10),
              backgroundColor: AppColors.lightSkyBlue,
            ),
          ],
        ));
  }

  /// Builds the price detail card with:
  /// - Header with icon
  /// - Price breakdown rows
  /// - Total price
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
            // Header with icon
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

            // Price breakdown rows
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

                // Divider line
                SizedBox(
                    width: Get.width,
                    child: SvgPicture.asset(Assets.images.svg.line5.path,
                        fit: BoxFit.fill)),
                const SizedBox(height: 20),

                // Total price row
                _buildPriceBreakDown(PriceBreakDownType.TOTAL_PAY, "30"),
              ],
            )
          ],
        ));
  }

  /// Builds a price breakdown row with:
  /// - Label
  /// - Price value
  /// - Different styling based on type (discount, total, etc.)
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

  /// Builds the submit button that changes based on flow type:
  /// - ROUTE_REQUEST_FLOW shows "Proceed" button
  /// - NORMAL_FLOW shows "Cancel Booking" button
  Widget _buildSubmitButton() {
    return (Get.arguments as TripDetailFlowType) ==
        TripDetailFlowType.ROUTE_REQUEST_FLOW
        ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField(
        customTextFieldType: CustomTextFieldType.BUTTON,
        textEditingController: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Proceed",
        keyboardType: TextInputType.none,
        textInputAction: TextInputAction.done,
        suffixIcon: Assets.images.svg.arrowRightGreen.path,
        onPressed: () {
          if (controller.isChecked.value) {
            CommonDropdownSelectionBottomSheet.showBottomSheet(
                commonList: <DummyCancellationReason>[].obs,
                dialogType: CommonDropdownSelectionBottomSheetDialogType
                    .SELECT_SEAT_SELECTION,
                onTap: (dialogType, selectedItemIndex) {
                  controller.onGoToPickupDropOfScreen();
                });
          } else {
            controller.onGoToPickupDropOfScreen();
          }
        },
      ),
    )
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: AppButton(
        onPressed: () {},
        buttonText: "Cancel Booking",
        buttonRadius: 32,
        buttonColor: AppColors.deepNavy,
        textFontSize: 18,
        textFontFamily: FontFamily.passengerSans,
        textFontWeight: FontWeight.w600,
      ),
    );
  }
}
