import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as CommonAppBottomSheet;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_conformation_app_bottom_sheet.dart';
import 'package:project_structure/core/widgets/custom/custom_route_card.dart';
import 'package:project_structure/gen/assets.gen.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/custom/custom_circle_icon.dart';
import '../../../core/widgets/custom/custom_text_filed.dart';
import '../dashboard_controller.dart';

class HomePage extends GetView<DashboardController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 32, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section with greeting and icons
              buildHeader(),
              const SizedBox(height: 40),

              // Search bar section
              buildSearchView(),
              const SizedBox(height: 40),

              // Explore Routes section title
              Text(
                "Explore Routes",
                style: TextStyles.text18SemiBold
                    .copyWith(color: AppColors.deepNavy),
              ),
              const SizedBox(height: 18),

              // Scrollable list of route cards
              Expanded(
                child: Obx(() => CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, index) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: GestureDetector(
                                    onTap: () {
                                      // TODO: Add route tap handler
                                    },
                                    child: CustomRouteCard(
                                      startLocation:
                                          "Manama Manama Manama Manama",
                                      endLocation:
                                          "Budaiya Budaiya Budaiya Budaiya",
                                      viaText: "Via Jidhafs & Budaiya Hwy",
                                      dateRange:
                                          "From: 1st Oct 2024 - To: 27th Oct 2024 From: 1st Oct 2024 - To: 27th Oct 2024",
                                      timeRange:
                                          "10:00 AM to 12:30 PM 10:00 AM to 12:30 PM",
                                      repeatText:
                                          "Weekly Recuring, Repeat after 2 weeks Weekly Recuring, Repeat after 2 weeks",
                                      distanceDuration: "60Km - 2:30 Hrs",
                                      routeNumber: "Route no. 12356",
                                      requestType: controller
                                          .routeDataList[index].requestType
                                          .orEmpty(),
                                      bottomNavigationScreenType: controller
                                          .activeBottomNavigationScreenType
                                          .value,
                                      onTap: () {
                                        controller.onGoToTripDetail();
                                      }
                                    ),
                                  )),
                              childCount: controller.routeDataList.length,
                            ),
                          )
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header row with greeting and action icons
  Widget buildHeader() {
    return Row(
      children: [
        // Greeting text column
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey, Parth!\uD83D\uDC4B",
              style: TextStyles.text14Regular
                  .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.6)),
            ),
            Text(
              "Let's find the Ride",
              style: TextStyles.text24SemiBold,
            )
          ],
        )),

        // Location icon button
        buildHeaderIcon(Assets.images.svg.location.path),
        const SizedBox(width: 8),

        // Notification icon button
        buildHeaderIcon(Assets.images.svg.notification.path),
      ],
    );
  }

  /// Builds a circular header icon button
  Widget buildHeaderIcon(String icon) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 11),
      decoration: BoxDecoration(
          color: AppColors.mintMist,
          borderRadius: const BorderRadius.all(Radius.circular(86))),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.none,
      ),
    );
  }

  /// Builds the search bar with filter functionality
  Widget buildSearchView() {
    return Row(children: [
      // Search icon
      CustomCircleIcon(
        iconPath: Assets.images.svg.search24.path,
        padding: const EdgeInsets.all(14),
        backgroundColor: AppColors.primary,
      ),
      const SizedBox(width: 8),

      // Search input field with filter button
      Expanded(
          child: CustomTextField(
        customTextFieldType: CustomTextFieldType.HOME_PAGE_SEARCH_FIELD,
        textEditingController: controller.searchController,
        focusNode: controller.searchFocusNode,
        hintText: "Search by Routes..",
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        suffixIcon: Assets.images.svg.filterUnselected.path,
        onPressed: () {
          // TODO: Implement filter functionality
        },
      ))
    ]);
  }
}
