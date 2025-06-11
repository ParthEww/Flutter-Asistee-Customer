import 'package:flutter/material.dart';
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
    return Obx(() => Scaffold(
          backgroundColor: AppColors.white,
          body: controller.dashboardPageList
              .elementAt(controller.activeBottomNavigationScreenType.value.page),
          bottomNavigationBar: buildBottomNavigationBar(),
        ));
  }

  Widget buildBottomNavigationBar() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.deepNavy,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(44), topRight: Radius.circular(44)),
          ),
          child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.mintMist,
                borderRadius: BorderRadius.circular(77),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildNavigationItems(
                      index: 0, icon: Assets.images.svg.bnvHome.path),
                  buildNavigationItems(
                      index: 1, icon: Assets.images.svg.bnvMyBookings.path),
                  buildNavigationItems(
                      index: 2, icon: Assets.images.svg.bnvMyRoutes.path),
                  buildNavigationItems(
                      index: 3, icon: Assets.images.svg.bnvSettings.path),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildNavigationItems({required int index, required String icon}) {
    return Obx(() => GestureDetector(
          onTap: () {
            if (controller.activeBottomNavigationScreenType.value.page != index) {
              controller.activeBottomNavigationScreenType.value = BottomNavigationScreenType.values[index];
            }
          },
          child: Stack(alignment: Alignment.center, children: [
            if (controller.activeBottomNavigationScreenType.value.page == index) ...[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: AppColors.secondary)),
              )
            ],
            SvgPicture.asset(icon, width: 52, height: 52, fit: BoxFit.none)
          ]),
        ));
  }
}
