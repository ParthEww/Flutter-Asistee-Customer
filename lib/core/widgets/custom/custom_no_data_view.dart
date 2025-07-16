import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

class CustomNoDataView extends StatelessWidget {
  final CustomNoDataViewType customNoDataViewType;
  final VoidCallback onTap;

  const CustomNoDataView(
      {super.key, required this.customNoDataViewType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.primary, width: 1.5, style: BorderStyle.solid),
        ),
        child: SvgPicture.asset(
          Assets.images.svg.route.path,
          fit: BoxFit.none,
        ),
      ),
      const SizedBox(height: 18),
      Text(customNoDataViewType.dialogTitle, style: TextStyles.text24SemiBold),
      const SizedBox(height: 8),
      Text(customNoDataViewType.dialogTitle,
          style: TextStyles.text14Regular
              .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.4))),
    ]);
  }
}

/// Enum for different types of dropdown selection dialogs
class CustomNoDataViewType {
  final String type;
  final String dialogTitle;
  final String dialogTitleIcon;
  final String searchHint;
  final String buttonText;

  const CustomNoDataViewType({
    required this.type,
    required this.dialogTitle,
    required this.dialogTitleIcon,
    required this.searchHint,
    required this.buttonText,
  });

  // Enum values
  static final SELECT_NATIONALITY = CustomNoDataViewType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.flag.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_AREA = CustomNoDataViewType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_FREQUENCY = CustomNoDataViewType(
    type: "Select Frequency in Define Booking Rule screen",
    dialogTitle: "Select Frequency",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for frequency",
    buttonText: "Select",
  );

  static final SELECT_YEAR = CustomNoDataViewType(
    type: "Select Year in Define Booking Rule screen",
    dialogTitle: "Select Year",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for year",
    buttonText: "Select",
  );

  static final SELECT_MONTH = CustomNoDataViewType(
    type: "Select Month in Define Booking Rule screen",
    dialogTitle: "Select Month Of The Year",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for month",
    buttonText: "Next",
  );

  static final SELECT_SUBJECT = CustomNoDataViewType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final CANCELATION_REASON = CustomNoDataViewType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_ROUTE_BOOKING_TYPE = CustomNoDataViewType(
    type: "Select Booking Option",
    dialogTitle: "Select Booking Option",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for booking option",
    buttonText: "Next",
  );

  static final SELECT_SEAT_SELECTION = CustomNoDataViewType(
    type: "Seat Selection",
    dialogTitle: "Seat Selection",
    dialogTitleIcon: Assets.images.svg.availableSeat16.path,
    searchHint: "Search for seat selection",
    buttonText: "Proceed",
  );

  static final START_DATE = CustomNoDataViewType(
    type: "Select Start Date",
    dialogTitle: "Select Start Date",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for start date",
    buttonText: "Select",
  );

  static final END_DATE = CustomNoDataViewType(
    type: "Select End Date",
    dialogTitle: "Select End Date",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for end date",
    buttonText: "Select",
  );

  static final START_TIME = CustomNoDataViewType(
    type: "Select Start Time",
    dialogTitle: "Select Start Time",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for start time",
    buttonText: "Select",
  );

  static final DAYS_OF_THE_WEEK = CustomNoDataViewType(
    type: "Select Days of the Week",
    dialogTitle: "Select Days of the Week",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for days of the week",
    buttonText: "Next",
  );

  static final DAYS_DATES = CustomNoDataViewType(
    type: "Select Days/Dates",
    dialogTitle: "Select Days/Dates",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for days/dates",
    buttonText: "Next",
  );

  static final ADD_FUNDS_TO_WALLET = CustomNoDataViewType(
    type: "Add Funds to Wallet",
    dialogTitle: "Add Funds to Wallet",
    dialogTitleIcon: Assets.images.svg.addToWalletWhite.path,
    searchHint: "Enter Amount",
    buttonText: "Add Funds",
  );
}
