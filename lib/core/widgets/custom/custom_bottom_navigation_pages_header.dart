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
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS ? Assets.images.svg.bus.path : Assets.images.svg.route.path,
              fit: BoxFit.none,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                ),
                const SizedBox(height: 28),
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

  Widget buildTabView(BookingStatusType type) {
    return Obx(() {
      return Expanded(
        child: GestureDetector(
          onTap: () => {
            if (controller.activeTabBarBookingStatus.value != type && controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS)
              {controller.activeTabBarBookingStatus.value = type}
          },
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_BOOKINGS
                    ? Text(
                        type.title,
                        style: TextStyles.text16SemiBold.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(
                                controller.activeTabBarBookingStatus.value ==
                                        type
                                    ? 1
                                    : 0.6)),
                      )
                    : Row(
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
                                            type || controller.activeBottomNavigationScreenType.value == BottomNavigationScreenType.MY_ROUTES
                                        ? 1
                                        : 0.6)),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 15),
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
