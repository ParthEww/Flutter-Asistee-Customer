import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/app_methods.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_styled_currency_text.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/app_text_field_required_label.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:retrofit/http.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../api/model/static/address_type.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import 'promo_codes_controller.dart';

class PromoCodesPage extends GetView<PromoCodesController> {
  const PromoCodesPage({super.key});

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
                  child: _buildScrollableContent(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Builds the background with two colored sections
  Widget _buildBackground() {
    return Column(
      children: [
        Container(
          height: Get.height * 0.21,
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

  /// Builds the custom app bar with back button and titles
  Widget _buildAppBar() {
    return Container(
      color: AppColors.primary,
      child: CustomHeader(
          title: "Promo Codes",
          isShowSubtitle: false,
          isShowBackButton: true,
          onBackButtonTap: () {
            Get.back();
          }),
    );
  }

  /// Builds the main scrollable content
  Widget _buildScrollableContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 30, right: 24),
      child: Column(
        children: [
          Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppColors.white, width: 6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                            controller: controller.promoCodeController,
                            focusNode: controller.promoCodeFocusNode,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            cursorColor: AppColors.deepNavy,
                            cursorHeight: TextStyles.text16Regular.height,
                            maxLength: 35,
                            cursorRadius: const Radius.circular(2),
                            style: TextStyles.text16Regular
                                .copyWith(color: AppColors.deepNavy),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(17),
                              counter: const SizedBox.shrink(),
                              filled: true,
                              fillColor: AppColors.white,
                              hintText: "Promo Code",
                              hintStyle: TextStyles.text14Regular.copyWith(
                                  color: AppColors.deepNavy
                                      .withOpacityPrecise(0.4)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1,
                                  )),
                            )),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 20),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(82))),
                        child: Text(
                          "Apply",
                          style: TextStyles.text14SemiBold
                              .copyWith(color: AppColors.white),
                        ),
                      )
                    ]),
              )),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return _buildPromoCodeItem();
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 18);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPromoCodeItem() {
    return Container(
        padding: const EdgeInsets.only(top: 18),
        decoration: BoxDecoration(
            color: AppColors.green.withOpacityPrecise(0.1),
            borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItemHeader(),
            const SizedBox(height: 14),
            _buildItemBody(),
            const SizedBox(height: 12),
            _buildItemFooter()
          ],
        ));
  }

  Widget _buildItemHeader() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(children: [
          CustomCircleIcon(
            iconPath: Assets.images.svg.promoCode.path,
            padding: const EdgeInsets.all(7),
            backgroundColor: AppColors.deepNavy,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "FIRSTRIP",
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyles.text18SemiBold.copyWith(color: AppColors.deepNavy),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 19),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(82))),
            child: Text(
              "Apply",
              style: TextStyles.text14SemiBold.copyWith(color: AppColors.white),
            ),
          )
        ]));
  }

  Widget _buildItemBody() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(() {
          return controller.isTermsAndConditionsChecked.value
              ? _buildTermsAndConditionsOfPromoCode()
              : IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: AppStyledCurrencyText(
                            text:
                                "Save BHD 10.00 on this and following 3 booking",
                            defaultStyle: TextStyles.text14Regular.copyWith(
                                color:
                                    AppColors.primary.withOpacityPrecise(0.4),
                                fontStyle: FontStyle.italic),
                            currencyStyle: TextStyles.text14Regular),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.isTermsAndConditionsChecked.value =
                                  true;
                            },
                            child: AppTextFieldRequiredLabel(
                              label: "T&C",
                              showRequiredMark: true,
                              showRequiredMarkOnFront: false,
                              showUnderLine: true,
                              labelColor:
                                  AppColors.deepNavy.withOpacityPrecise(0.6),
                              requireLabelColor:
                                  AppColors.deepNavy.withOpacityPrecise(0.6),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
        }));
  }

  Widget _buildTermsAndConditionsOfPromoCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.isTermsAndConditionsChecked.value = false;
              },
              child: Transform.rotate(
                  angle: pi,
                  child: SvgPicture.asset(Assets.images.svg.arrowRight18.path)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                "Terms & Conditions",
                style: TextStyles.text14SemiBold
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return IntrinsicHeight(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(
                    children: [
                      Text(
                        "•",
                        style: TextStyles.text14Regular.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(0.4)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        style: TextStyles.text14Regular.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(0.4))),
                  ))
                ]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 12);
            },
          ),
        )
      ],
    );
  }

  Widget _buildItemFooter() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              width: 9,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
            ),
          ),
          Expanded(
              child: Center(
                  child: Text("60% OFF",
                      style: TextStyles.text18Bold
                          .copyWith(color: AppColors.mintCream)))),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Transform.rotate(
              angle: pi,
              child: Container(
                width: 9,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
