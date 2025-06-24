import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';

import '../../../gen/assets.gen.dart';
import '../../../pages/dashboard/dashboard_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomHeaderWithTab extends StatelessWidget {
  final DashboardController controller;
  final bool isBnvHeader;
  final VoidCallback? onTap;

  const CustomHeaderWithTab(
      {super.key, required this.controller, required this.isBnvHeader, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: isBnvHeader ? 24 : 0),
      child: Stack(
        children: [
          // Decorative background icon (changes based on active screen)
          if (isBnvHeader) ...[
            Positioned(
              right: 0,
              child: SvgPicture.asset(
                controller.activeBottomNavigationScreenType.value ==
                        BottomNavigationScreenType.MY_BOOKINGS
                    ? Assets.images.svg.bus.path
                    : Assets.images.svg.route.path,
                fit: BoxFit.none,
              ),
            )
          ],

          // Main content with title and tab bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Screen title (changes based on active screen)
                if (isBnvHeader) ...[
                  Text(
                    switch (controller.activeBottomNavigationScreenType.value) {
                      BottomNavigationScreenType.HOME => "Home",
                      BottomNavigationScreenType.MY_BOOKINGS => "My Bookings",
                      BottomNavigationScreenType.MY_ROUTES => "My Routes",
                      BottomNavigationScreenType.SETTINGS => "Settings",
                      _ => ""
                    },
                    style: TextStyles.text24SemiBold
                        .copyWith(color: AppColors.white),
                  )
                ]else ...[
                  CustomHeader(
                    title: "Pickup & Dropoff",
                    isShowSubtitle: false,
                    isShowBackButton: true,
                    isHorizontalPaddingApply: false,
                    onBackButtonTap: (){
                      Get.back;
                    },
                  )
                ],
                const SizedBox(height: 28),

                // Tab bar container with custom border styling
                Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(38),
                            topRight: Radius.circular(38)),
                        border: Border(
                            left: BorderSide(
                              color: AppColors.white,
                              width: 6,
                            ),
                            top: BorderSide(
                              color: AppColors.white,
                              width: 6,
                            ),
                            right: BorderSide(
                              color: AppColors.white,
                              width: 6,
                            ))),
                    child: Row(
                      children: List.generate(
                        // Generate tabs based on current screen type
                        isBnvHeader
                            ? controller.activeBottomNavigationScreenType
                                        .value ==
                                    BottomNavigationScreenType.MY_BOOKINGS
                                ? controller.myBookingsTabList.length
                                : controller.myRootsTabList.length
                            : controller.pickupDropOffTabList.length,
                        (index) => buildTabView(isBnvHeader
                            ? controller.activeBottomNavigationScreenType
                                        .value ==
                                    BottomNavigationScreenType.MY_BOOKINGS
                                ? controller.myBookingsTabList[index]
                                : controller.myRootsTabList[index]
                            : controller.pickupDropOffTabList[index]),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an individual tab view item with interactive styling
  Widget buildTabView(BookingStatusType type) {
    return Obx(() {
      return Expanded(
        child: GestureDetector(
          onTap: () => {
            onTap?.call(),
            // Update active tab only for My Bookings screen
            if (isBnvHeader)
              {
                if (controller.activeTabBarBookingStatus.value != type &&
                    controller.activeBottomNavigationScreenType.value ==
                        BottomNavigationScreenType.MY_BOOKINGS)
                  {controller.activeTabBarBookingStatus.value = type}
              }
            else
              {
                if (controller.activeTabBarBookingStatus.value != type)
                  {controller.activeTabBarBookingStatus.value = type}
              }
          },
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: controller.activeBottomNavigationScreenType.value ==
                        BottomNavigationScreenType.MY_BOOKINGS || !isBnvHeader
                    ? // Text-only tab for My Bookings
                    Text(
                        type.title,
                        style: TextStyles.text16SemiBold.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(
                                controller.activeTabBarBookingStatus.value ==
                                        type
                                    ? 1
                                    : 0.6)),
                      )
                    : // Icon + Text tab for other screens
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (type.icon != null) SvgPicture.asset(type.icon!),
                          const SizedBox(width: 12),
                          Text(
                            type.title,
                            style: TextStyles.text16SemiBold.copyWith(
                                color: AppColors.deepNavy.withOpacityPrecise(
                                    controller.activeTabBarBookingStatus
                                                    .value ==
                                                type ||
                                            controller
                                                    .activeBottomNavigationScreenType
                                                    .value ==
                                                BottomNavigationScreenType
                                                    .MY_ROUTES
                                        ? 1
                                        : 0.6)),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 15),

              // Active tab indicator (only for My Bookings screen)
              if (controller.activeBottomNavigationScreenType.value ==
                  BottomNavigationScreenType.MY_BOOKINGS || !isBnvHeader) ...[
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: controller.activeTabBarBookingStatus.value == type
                        ? AppColors.primary
                        : AppColors.transparent,
                  ),
                )
              ]
            ],
          ),
        ),
      );
    });
  }
}
