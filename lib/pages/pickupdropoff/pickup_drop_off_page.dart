import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/app_text_field_required_label.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_header_with_tab.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:project_structure/pages/dashboard/dashboard_controller.dart';
import 'package:retrofit/http.dart';

import '../../api/model/static/address_type.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import '../../core/widgets/custom/custom_ongoing_route_card.dart';
import '../../core/widgets/custom/custom_route_card.dart';
import 'pickup_drop_off_controller.dart';

class PickupDropOffPage extends GetView<DashboardController> {
  const PickupDropOffPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.activeTabBarBookingStatus.value = BookingStatusType.PICK_UP;
    controller.commonTabList = [
      BookingStatusType.PICK_UP,
      BookingStatusType.DROP_OFF
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: Column(children: [
        CustomHeaderWithTab(
          controller: controller,
          isBnvHeader: false,
        ),
        Expanded(
            child: Container(
                width: Get.width,
                height: Get.height,
                color: AppColors.white,
                padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                child: Obx(() {
                  print(controller.activeTabBarBookingStatus.value.title);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.activeTabBarBookingStatus.value ==
                                BookingStatusType.PICK_UP
                            ? "Select Pick Up Point"
                            : "Select Drop-Off Point",
                        style: TextStyles.text18SemiBold
                            .copyWith(color: AppColors.deepNavy),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                        child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (_, index) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: _buildPickupDropOffView()),
                                  childCount: 10,
                                ),
                              )
                            ]),
                      )
                    ],
                  );
                }))),
        Container(
          color: AppColors.white,
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
              if (controller.activeTabBarBookingStatus.value == BookingStatusType.PICK_UP){
                controller.activeTabBarBookingStatus.value = BookingStatusType.DROP_OFF;
                return;
              }
              controller.onGoToBookingSummary();
            },
          ),
        )
      ])),
    );
  }

  Widget _buildPickupDropOffView() {
    return GestureDetector(
      onTap: () {
        // Handle tap event for the entire container
      },
      child: Container(
        // Padding for the container (more on left and top)
        padding: const EdgeInsets.only(left: 18, top: 16, right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(24), // Rounded corners
        ),
        child: IntrinsicHeight(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Radio button (unselected state)
              SvgPicture.asset(Assets.images.svg.radioUnselected.path),
              const SizedBox(width: 24), // Spacer

              // Expanded content column (takes remaining space)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location title
                    Text("Busaiteen, Bahrain",
                        style: TextStyles.text14SemiBold),
                    const SizedBox(height: 8), // Vertical spacer

                    // Time and date row
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time icon and text
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.images.svg.clock.path,
                                colorFilter: ColorFilter.mode(
                                  AppColors.deepNavy,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "10:00 AM",
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false,
                                    applyHeightToLastDescent: false),
                                style: TextStyles.text12SemiBold.copyWith(
                                  color: AppColors.deepNavy
                                      .withOpacityPrecise(0.6),
                                ),
                              )
                            ],
                          ),
                          // Vertical divider
                          const SizedBox(width: 6),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Container(
                              color: AppColors.green,
                              width: 1,
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Calendar icon and date text
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Assets.images.svg.calendar.path,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.deepNavy,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "From: 1st Oct 2024 - To: 27th Oct 2024",
                                    maxLines: 2,
                                    softWrap: true,
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false,
                                        applyHeightToLastDescent: false),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.text12SemiBold.copyWith(
                                      color: AppColors.deepNavy
                                          .withOpacityPrecise(0.6),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomCircleIcon(
                    iconPath: Assets.images.svg.map.path,
                    padding: const EdgeInsets.all(8),
                    backgroundColor: AppColors.deepNavy,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
