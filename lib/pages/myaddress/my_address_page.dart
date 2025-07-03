import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/app_methods.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:project_structure/pages/dashboard/dashboard_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/widgets/custom/custom_circle_icon.dart';
import '../../core/widgets/custom/custom_header_with_tab.dart';
import '../bookingsummary/booking_summary_page.dart';
import 'my_address_controller.dart';

class MyAddressPage extends GetView<MyAddressController> {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    CommonUtils.activeTabBarBookingStatus.value = BookingStatusType.MY_ADDRESS;
    CommonUtils.commonTabList = [BookingStatusType.MY_ADDRESS];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: Column(children: [
        CustomHeaderWithTab(
          isBnvHeader: false,
          onTap: (){
            controller.onGoToAddNewAddress();
          },
        ),
        Expanded(
            child: Container(
                width: Get.width,
                height: Get.height,
                color: AppColors.white,
                padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                child: Obx(() {
                  print(CommonUtils.activeTabBarBookingStatus.value.title);
                  return Expanded(
                    child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, index) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: _buildMyAddressItem()),
                              childCount: 10,
                            ),
                          )
                        ]),
                  );
                }))),
      ])),
    );
  }

  Widget _buildMyAddressItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightMint,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacityPrecise(0.14),
            borderRadius: BorderRadius.circular(62),
          ),
          child: Row(children: [
            CustomCircleIcon(
              iconPath: Assets.images.svg.route20.path,
              padding: const EdgeInsets.all(10),
              backgroundColor: AppColors.deepNavy,
            ),
            const SizedBox(width: 14),
            Expanded(
                child: Text("Home",
                    style: TextStyles.text16SemiBold
                        .copyWith(color: AppColors.deepNavy))),
            CustomCircleIcon(
              iconPath: Assets.images.svg.deleteAddress.path,
              padding: const EdgeInsets.all(8),
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(width: 4),
            CustomCircleIcon(
              iconPath: Assets.images.svg.editPen.path,
              padding: const EdgeInsets.all(8),
              backgroundColor: AppColors.white,
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          child: Text(
              "Room 481, 4th Floor Manama Central Building 21 Government Avenue Manama 306",
              style:
                  TextStyles.text14Regular.copyWith(color: AppColors.deepNavy)),
        )
      ]),
    );
  }
}
