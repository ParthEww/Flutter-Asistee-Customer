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
import 'contact_us_controller.dart';

// Main contact us page widget
class ContactUsPage extends GetView<ContactUsController> {
  const ContactUsPage({super.key});

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
          title: "Contact Us",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking id input field
            CustomTextField(
              customTextFieldType: CustomTextFieldType.BOOKING_ID,
              textEditingController: controller.bookingIdController,
              focusNode: controller.bookingIdFocusNode,
              nextFocusNode: controller.emailOrPhoneNumberFocusNode,
              // Moves to phone number field on next
              hintText: "Booking Id(optional)",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              suffixIcon: Assets.images.svg.note.path,
            ),
            const SizedBox(height: 14),
            // Email or Phone input field
            CustomTextField(
              customTextFieldType: CustomTextFieldType.CONTACT_US_EMAIL_OR_PHONE_NUMBER,
              textEditingController: controller.emailOrPhoneNumberController,
              focusNode: controller.emailOrPhoneNumberFocusNode,
              nextFocusNode: controller.subjectFocusNode,
              // Moves to phone number field on next
              hintText: "Email/Phone",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              suffixIcon: Assets.images.svg.emailWhite.path,
            ),
            const SizedBox(height: 14),
            // subject input field
            CustomTextField(
              customTextFieldType: CustomTextFieldType.SUBJECT,
              textEditingController: controller.subjectController,
              focusNode: controller.subjectFocusNode,
              nextFocusNode: controller.additionalNoteFocusNode,
              // Moves to phone number field on next
              hintText: "Subject",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              suffixIcon: Assets.images.svg.cprWhite.path,
            ),
            const SizedBox(height: 14),
            // additional note input field
            CustomTextField(
              customTextFieldType: CustomTextFieldType.ADDITIONAL_NOTE,
              textEditingController: controller.additionalNoteController,
              focusNode: controller.additionalNoteFocusNode,
              // Moves to phone number field on next
              hintText: "Write your message...",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              suffixIcon: Assets.images.svg.cprWhite.path,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFooterRow() {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 4, right: 4, bottom: 4),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            "Add Funds to Wallet",
            style: TextStyles.text14SemiBold.copyWith(color: AppColors.white),
          )),
          Container(
            padding: EdgeInsets.only(left: 2, top: 2, right: 18, bottom: 2),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(21)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCircleIcon(
                  iconPath: Assets.images.svg.addToWallet.path,
                  padding: const EdgeInsets.all(8),
                  backgroundColor: AppColors.mintCream,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    CommonDropdownSelectionBottomSheet.showBottomSheet(
                        commonList: [].obs,
                        dialogType: CommonDropdownSelectionBottomSheetDialogType.ADD_FUNDS_TO_WALLET,
                        onTap: (dialogType, selectedItemIndex){

                        }
                    );
                  },
                  child: Text(
                    "Add",
                    style: TextStyles.text14SemiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Driver avatar
        CustomCircleIcon(
            iconPath: Assets.images.svg.moneyCreditArrow.path,
          padding: const EdgeInsets.all(13),
          backgroundColor: AppColors.lightSkyBlue,
        ),
        const SizedBox(width: 18),

        // Driver info
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Yay-12463",
                    style: TextStyles.text14Regular.copyWith(color: AppColors.deepNavy),
                  ),
                  Text(
                    "08:45 AM, 22 Jul ‘24",
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.text12Regular.copyWith(
                        fontStyle: FontStyle.italic),
                  )
                ])),

        PriceText(
          amount: "-BD 25.00",
          parentTextStyle: TextStyles.text16SemiBold,
          childTextStyle: TextStyles.text12SemiBold,
          parentTextColor: AppColors.deepNavy,
          childTextColor: AppColors.deepNavy.withOpacityPrecise(0.4),
        ),
      ],
    );
  }
}
