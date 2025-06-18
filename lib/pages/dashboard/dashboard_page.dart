import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';

import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => PopScope(
      // Prevent default back navigation
      canPop: false,

      // Custom back button handling
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          // If not on home screen, navigate to home
          if (controller.activeBottomNavigationScreenType.value !=
              BottomNavigationScreenType.HOME) {
            controller.activeBottomNavigationScreenType.value =
                BottomNavigationScreenType.HOME;
          } else {
            // If already on home, exit app
            SystemNavigator.pop();
          }
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.white,
        // Display current active page based on navigation state
        body: controller.dashboardPageList
            .elementAt(controller.activeBottomNavigationScreenType.value.page),
        // Custom bottom navigation bar
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    ));
  }

  /// Builds the custom bottom navigation bar
  Widget buildBottomNavigationBar() {
    return SizedBox(
      height: 100, // Fixed height for navigation bar
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.only(
              left: 12,
              top: 12,
              right: 12,
              bottom: 12
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.deepNavy,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(44),
                topRight: Radius.circular(44)
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.mintMist,
              borderRadius: BorderRadius.circular(77),
            ),
            // Navigation items row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home button
                buildNavigationItems(
                    index: 0,
                    icon: Assets.images.svg.bnvHome.path
                ),
                // My Bookings button
                buildNavigationItems(
                    index: 1,
                    icon: Assets.images.svg.bnvMyBookings.path
                ),
                // My Routes button
                buildNavigationItems(
                    index: 2,
                    icon: Assets.images.svg.bnvMyRoutes.path
                ),
                // Settings button
                buildNavigationItems(
                    index: 3,
                    icon: Assets.images.svg.bnvSettings.path
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds individual navigation items with active state indicator
  Widget buildNavigationItems({required int index, required String icon}) {
    return Obx(() => GestureDetector(
      onTap: () {
        // Only update if selecting a different tab
        if (controller.activeBottomNavigationScreenType.value.page != index) {
          controller.activeBottomNavigationScreenType.value =
          BottomNavigationScreenType.values[index];
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Active tab indicator (white circle background)
          if (controller.activeBottomNavigationScreenType.value.page == index)
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1,
                    color: AppColors.secondary
                ),
              ),
            ),
          // Navigation icon
          SvgPicture.asset(
              icon,
              width: 52,
              height: 52,
              fit: BoxFit.none
          )
        ],
      ),
    ));
  }
}
