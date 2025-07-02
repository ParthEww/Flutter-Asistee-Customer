import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/api/model/dummy/dummy_cancellation_reason.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/app_text_field_required_label.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/core/widgets/price_text.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../api/model/static/address_type.dart';
import '../../core/utils/app_methods.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import '../bookingsummary/booking_summary_page.dart';
import 'faqs_controller.dart';

// Main contact us page widget
class FaqsPage extends GetView<FaqsController> {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Background with 30% primary color and 70% white
          _buildBackground(),

          // Main content with SafeArea
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                _buildAppBar(),

                // Scrollable content area
                Expanded(
                  child: _buildWalletBalanceCard(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Builds the background with two colored sections:
  /// - Top 30% with primary color
  /// - Bottom 70% with white color
  Widget _buildBackground() {
    return Column(
      children: [
        Container(
          height: Get.height * 0.28,
          color: AppColors.primary,
        ),
        Expanded(
          child: Container(
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  /// Builds the custom app bar with:
  /// - Back button
  /// - Title and subtitle
  Widget _buildAppBar() {
    return Container(
      color: AppColors.primary,
      child: CustomHeader(
          title: "Faqs",
          isShowSubtitle: false,
          isShowBackButton: true,
          onBackButtonTap: () {
            Get.back();
          }),
    );
  }

  Widget _buildWalletBalanceCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 30, right: 24),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.white, width: 6),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return _buildFaqItem();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 14);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem() {
    var isFaqItemExpanded = false.obs;
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 24, top: 4, right: 4, bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacityPrecise(0.8),
                borderRadius: BorderRadius.circular(26),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          "What is the Booking Process? Is there any refund I'll get if I cancel the ride?",
                          style: TextStyles.text14Regular
                              .copyWith(color: AppColors.deepNavy),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isFaqItemExpanded.value = !isFaqItemExpanded.value;
                          },
                          child: Transform.rotate(
                            angle: isFaqItemExpanded.value ? 0 : pi,
                            child: CustomCircleIcon(
                              iconPath: Assets.images.svg.arrowDown24.path,
                              padding: const EdgeInsets.all(16),
                              backgroundColor: isFaqItemExpanded.value
                                  ? AppColors.deepNavy
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (isFaqItemExpanded.value) ...[
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard.\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.",
                  style: TextStyles.text12Regular
                      .copyWith(color: AppColors.deepNavy),
                ),
              )
            ]
          ],
        ),
      );
    });
  }
}
