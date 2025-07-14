import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';

import '../../../gen/assets.gen.dart';
import '../../../pages/dashboard/dashboard_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomHeaderWithTab extends StatelessWidget {
  final DashboardController? controller;
  final bool isBnvHeader;
  final VoidCallback? onTap;

  const CustomHeaderWithTab(
      {super.key, this.controller, required this.isBnvHeader, this.onTap});

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
                controller?.activeBottomNavigationScreenType.value ==
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
                    switch (
                        controller?.activeBottomNavigationScreenType.value) {
                      BottomNavigationScreenType.HOME => "Home",
                      BottomNavigationScreenType.MY_BOOKINGS => "My Bookings",
                      BottomNavigationScreenType.MY_ROUTES => "My Routes",
                      BottomNavigationScreenType.SETTINGS => "Settings",
                      _ => ""
                    },
                    style: TextStyles.text24SemiBold
                        .copyWith(color: AppColors.white),
                  )
                ] else ...[
                  CustomHeader(
                    title: "Pickup & Dropoff",
                    isShowSubtitle: false,
                    isShowBackButton: true,
                    isHorizontalPaddingApply: false,
                    onBackButtonTap: () {
                      /*Get.back;*/
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
                        CommonUtils.commonTabList.length,
                        (index) =>
                            buildTabView(CommonUtils.commonTabList[index]),
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
    return SizedBox(); /*Obx(() {
      return Expanded(
        child: GestureDetector(
          onTap: () => {
            onTap?.call(),
            // Update active tab only for My Bookings screen
            if (isBnvHeader)
              {
                if (CommonUtils.activeTabBarBookingStatus.value != type &&
                    controller?.activeBottomNavigationScreenType.value ==
                        BottomNavigationScreenType.MY_BOOKINGS)
                  {CommonUtils.activeTabBarBookingStatus.value = type}
              }
            else
              {
                if (CommonUtils.activeTabBarBookingStatus.value != type)
                  {CommonUtils.activeTabBarBookingStatus.value = type}
              }
          },
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: CommonUtils.commonTabList.length > 1
                    ? // Text-only tab for My Bookings
                    Text(
                        type.title,
                        style: TextStyles.text16SemiBold.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(
                                CommonUtils.activeTabBarBookingStatus.value ==
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
                                    CommonUtils.activeTabBarBookingStatus
                                                    .value ==
                                                type ||
                                            controller
                                                    ?.activeBottomNavigationScreenType
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
              if (CommonUtils.commonTabList.length > 1 && isBnvHeader) ...[
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: CommonUtils.activeTabBarBookingStatus.value == type
                        ? AppColors.primary
                        : AppColors.transparent,
                  ),
                )
              ]
            ],
          ),
        ),
      );
    });*/
  }
}
