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
              Assets.images.svg.bus.path,
              fit: BoxFit.none,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  switch (controller.activeBottomBarIndex.value) {
                    0 => "Home",
                    1 => "My Bookings",
                    2 => "My Routes",
                    3 => "Settings",
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
                        controller.activeBottomBarIndex.value == 1
                            ? controller.myBookingsTabList.length
                            : controller.myRootsTabList.length,
                        (index) => buildTabView(
                            controller.activeBottomBarIndex.value == 1
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
            if (controller.activeTabBarBookingStatus.value != type)
              {controller.activeTabBarBookingStatus.value = type}
          },
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: controller.activeBottomBarIndex.value == 1
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
                                            type
                                        ? 1
                                        : 0.6)),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: controller.activeTabBarBookingStatus.value == type
                      ? AppColors.primary
                      : AppColors.transparent,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
