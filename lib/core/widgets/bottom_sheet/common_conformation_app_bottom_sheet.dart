import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_structure/api/model/dummy/dummy_cancellation_reason.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../api/model/static/route_request_type.dart';
import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import '../../utils/app_methods.dart';
import '../custom/custom_circle_icon.dart';
import '../custom/custom_text_filed.dart';
import '../custom/custom_time_wheel_picker.dart';

class CommonConformationAppBottomSheet extends StatelessWidget {
  final Function(CommonConformationAppBottomSheetDialogType, int)? onTap;

  const CommonConformationAppBottomSheet({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: _calculateDialogHeight(context),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  /*width: Get.width,*/
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32)),
                  ),
                  child: SvgPicture.asset(Assets.images.svg.msgSubmitted.path,
                      fit: BoxFit.none),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Message Submitted!",
                  style: TextStyles.text18SemiBold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Your message has been delivered to the Super Admin for Support.",
                  textAlign: TextAlign.center,
                  style: TextStyles.text14Regular.copyWith(
                      color: AppColors.deepNavy.withOpacityPrecise(0.4)),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: CustomTextField(
                    customTextFieldType: CustomTextFieldType.BUTTON,
                    textEditingController: TextEditingController(),
                    focusNode: FocusNode(),
                    hintText: "Okay",
                    keyboardType: TextInputType.none,
                    textInputAction: TextInputAction.done,
                    suffixIcon: Assets.images.svg.arrowRightGreen.path,
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Calculates the appropriate height based on dialog type
  double _calculateDialogHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.47;
  }

  /// Shows the bottom sheet dialog
  static void showBottomSheet({
    Function(CommonConformationAppBottomSheetDialogType, int)? onTap,
  }) {
    /*showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return CommonConformationAppBottomSheet(onTap: onTap);
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.transparent,
      // Transparent background for overlay effect
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: false,
    );*/
  }
}

/// Enum for different types of dropdown selection dialogs
class CommonConformationAppBottomSheetDialogType {
  final String type;
  final String dialogTitle;
  final String dialogTitleIcon;
  final String searchHint;
  final String buttonText;

  const CommonConformationAppBottomSheetDialogType({
    required this.type,
    required this.dialogTitle,
    required this.dialogTitleIcon,
    required this.searchHint,
    required this.buttonText,
  });

  // Enum values
  static final SELECT_NATIONALITY = CommonConformationAppBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.flag.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_AREA = CommonConformationAppBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_FREQUENCY = CommonConformationAppBottomSheetDialogType(
    type: "Select Frequency in Define Booking Rule screen",
    dialogTitle: "Select Frequency",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for frequency",
    buttonText: "Select",
  );

  static final SELECT_YEAR = CommonConformationAppBottomSheetDialogType(
    type: "Select Year in Define Booking Rule screen",
    dialogTitle: "Select Year",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for year",
    buttonText: "Select",
  );

  static final SELECT_MONTH = CommonConformationAppBottomSheetDialogType(
    type: "Select Month in Define Booking Rule screen",
    dialogTitle: "Select Month Of The Year",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for month",
    buttonText: "Next",
  );

  static final SELECT_SUBJECT = CommonConformationAppBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final CANCELATION_REASON = CommonConformationAppBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_ROUTE_BOOKING_TYPE = CommonConformationAppBottomSheetDialogType(
    type: "Select Booking Option",
    dialogTitle: "Select Booking Option",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for booking option",
    buttonText: "Next",
  );

  static final SELECT_SEAT_SELECTION = CommonConformationAppBottomSheetDialogType(
    type: "Seat Selection",
    dialogTitle: "Seat Selection",
    dialogTitleIcon: Assets.images.svg.availableSeat16.path,
    searchHint: "Search for seat selection",
    buttonText: "Proceed",
  );

  static final START_DATE = CommonConformationAppBottomSheetDialogType(
    type: "Select Start Date",
    dialogTitle: "Select Start Date",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for start date",
    buttonText: "Select",
  );

  static final END_DATE = CommonConformationAppBottomSheetDialogType(
    type: "Select End Date",
    dialogTitle: "Select End Date",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for end date",
    buttonText: "Select",
  );

  static final START_TIME = CommonConformationAppBottomSheetDialogType(
    type: "Select Start Time",
    dialogTitle: "Select Start Time",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for start time",
    buttonText: "Select",
  );

  static final DAYS_OF_THE_WEEK = CommonConformationAppBottomSheetDialogType(
    type: "Select Days of the Week",
    dialogTitle: "Select Days of the Week",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for days of the week",
    buttonText: "Next",
  );

  static final DAYS_DATES = CommonConformationAppBottomSheetDialogType(
    type: "Select Days/Dates",
    dialogTitle: "Select Days/Dates",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for days/dates",
    buttonText: "Next",
  );

  static final ADD_FUNDS_TO_WALLET = CommonConformationAppBottomSheetDialogType(
    type: "Add Funds to Wallet",
    dialogTitle: "Add Funds to Wallet",
    dialogTitleIcon: Assets.images.svg.addToWalletWhite.path,
    searchHint: "Enter Amount",
    buttonText: "Add Funds",
  );
}
