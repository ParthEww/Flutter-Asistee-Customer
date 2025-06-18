import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../../pages/dashboard/dashboard_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomBottomNavigationPagesHeader extends StatelessWidget {
  final DashboardController controller;

  const CustomBottomNavigationPagesHeader(
      {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Stack(
        children: [
          // Decorative background icon (changes based on active screen)
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS
                  ? Assets.images.svg.bus.path
                  : Assets.images.svg.route.path,
              fit: BoxFit.none,
            ),
          ),

          // Main content with title and tab bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Screen title (changes based on active screen)
                Text(
                  switch (controller.activeBottomNavigationScreenType.value) {
                    BottomNavigationScreenType.HOME => "Home",
                    BottomNavigationScreenType.MY_BOOKINGS => "My Bookings",
                    BottomNavigationScreenType.MY_ROUTES => "My Routes",
                    BottomNavigationScreenType.SETTINGS => "Settings",
                    _ => ""
                  },
                  style: TextStyles.text24SemiBold.copyWith(color: AppColors.white),
                ),
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
                        controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS
                            ? controller.myBookingsTabList.length
                            : controller.myRootsTabList.length,
                            (index) => buildTabView(
                            controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS
                                ? controller.myBookingsTabList[index]
                                : controller.myRootsTabList[index]),
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
            // Update active tab only for My Bookings screen
            if (controller.activeTabBarBookingStatus.value != type &&
                controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS)
              {controller.activeTabBarBookingStatus.value = type}
          },
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS
                    ? // Text-only tab for My Bookings
                Text(
                  type.title,
                  style: TextStyles.text16SemiBold.copyWith(
                      color: AppColors.deepNavy.withOpacityPrecise(
                          controller.activeTabBarBookingStatus.value == type ? 1 : 0.6)),
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
                              controller.activeTabBarBookingStatus.value == type ||
                                  controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_ROUTES
                                  ? 1
                                  : 0.6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Active tab indicator (only for My Bookings screen)
              if(controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS) ...[
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
