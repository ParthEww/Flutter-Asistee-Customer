import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yay_rider_driver/core/themes/app_colors.dart';
import 'package:flutter_yay_rider_driver/core/themes/text_styles.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';
import 'package:flutter_yay_rider_driver/core/widgets/bottom_sheet/commondropdownselection/common_dropdown_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../api/model/dummy/dummy_cancellation_reason.dart';
import '../../../../api/model/static/route_request_type.dart';
import '../../../../gen/assets.gen.dart';
import '../../custom/custom_text_filed.dart';

// Enum for Days/Dates selection type
enum DaysDatesType {
  DAYS(title: "Repeat on Days", isSelected: true),
  DATES(title: "Repeat on Dates", isSelected: false);

  final String title;
  final bool isSelected;

  const DaysDatesType({required this.title, required this.isSelected});
}

/// A reusable bottom sheet component for various selection scenarios
/// Supports different types of selection dialogs with consistent UI
class CommonDropdownSheet extends ConsumerWidget {
  final CommonDropdownSelectionBottomSheetDialogType dialogType;
  final List<dynamic> initialItems;
  final Function(int)? onSelected;

  const CommonDropdownSheet({
    super.key,
    required this.dialogType,
    required this.initialItems,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: _calculateDialogHeight(context),
          padding: const EdgeInsets.all(18),
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
              _buildHeaderSection(),
              const SizedBox(height: 24),
              Expanded(
                child: _buildContentSection(context, ref),
              ),
              const SizedBox(height: 18),
              _buildFooterButtons(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  /// Calculates the appropriate height based on dialog type
  double _calculateDialogHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (dialogType ==
            CommonDropdownSelectionBottomSheetDialogType
                .SELECT_SEAT_SELECTION ||
        dialogType ==
            CommonDropdownSelectionBottomSheetDialogType.ADD_FUNDS_TO_WALLET) {
      return screenHeight * 0.37;
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType
            .SELECT_ROUTE_BOOKING_TYPE) {
      return screenHeight * 0.4;
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.START_TIME) {
      return screenHeight * 0.55;
    } else if (dialogType ==
            CommonDropdownSelectionBottomSheetDialogType.START_DATE ||
        dialogType == CommonDropdownSelectionBottomSheetDialogType.END_DATE) {
      return screenHeight * 0.65;
    } else {
      return screenHeight * 0.7;
    }
  }

  /// Builds the header section with icon and title
  Widget _buildHeaderSection() {
    return Row(
      children: [
        // Circular Icon Container
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.deepNavy,
          ),
          child: SvgPicture.asset(
            dialogType.dialogTitleIcon,
            fit: BoxFit.none,
          ),
        ),
        const SizedBox(width: 12),
        // Title Text
        Text(
          dialogType.dialogTitle,
          style: TextStyles.text14SemiBold.copyWith(
            color: dialogType ==
                    CommonDropdownSelectionBottomSheetDialogType
                        .ADD_FUNDS_TO_WALLET
                ? AppColors.deepNavy
                : AppColors.primary,
          ),
        ),
      ],
    );
  }

  /// Builds the main content section based on dialog type
  Widget _buildContentSection(BuildContext context, WidgetRef ref) {
    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.SELECT_SEAT_SELECTION) {
      return _buildSeatSelectionContent();
    } else if (dialogType ==
            CommonDropdownSelectionBottomSheetDialogType.START_DATE ||
        dialogType == CommonDropdownSelectionBottomSheetDialogType.END_DATE) {
      return Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 22),
        ],
      );
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.START_TIME) {
      return Column(
        children: [
          _buildTimeWheelPicker(),
          const SizedBox(height: 22),
        ],
      );
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.DAYS_DATES) {
      return _buildDaysDatesContent(ref);
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.ADD_FUNDS_TO_WALLET) {
      return _buildAddFundsToWallet();
    } else {
      return _buildDefaultListContent(ref);
    }
  }

  /// Builds content for seat selection type
  Widget _buildSeatSelectionContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildNumberOfSeatsCard(),
          const SizedBox(height: 14),
          Text(
            "Select the total number of seats required for\nyour Booking",
            style:
                TextStyles.text12Regular.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  /// Builds number of seats card with increment/decrement controls
  Widget _buildNumberOfSeatsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, top: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.lightMint,
        borderRadius: BorderRadius.circular(82),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "No. of Seat",
            style: TextStyles.text16SemiBold,
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Assets.images.svg.minus.path,
                    fit: BoxFit.none),
                Text(
                  "3",
                  style: TextStyles.text14SemiBold.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                  ),
                ),
                SvgPicture.asset(Assets.images.svg.plus.path, fit: BoxFit.none),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds content for days/dates selection type
  Widget _buildDaysDatesContent(WidgetRef ref) {
    final state = ref.watch(commonDropdownNotifierProvider);
    final notifier = ref.read(commonDropdownNotifierProvider.notifier);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToggleButton(
                DaysDatesType.DAYS,
                state.daysDatesType == DaysDatesType.DAYS,
                () => notifier.toggleDaysDatesType(),
              ),
              const SizedBox(width: 12),
              _buildToggleButton(
                DaysDatesType.DATES,
                state.daysDatesType == DaysDatesType.DATES,
                () => notifier.toggleDaysDatesType(),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: state.daysDatesType == DaysDatesType.DAYS
                ? _buildDaysList(ref)
                : _buildCalendar(),
          ),
        ],
      ),
    );
  }

  /// Builds a toggle button for days/dates selection
  Widget _buildToggleButton(
    DaysDatesType type,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.lightBlue,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            type.title,
            style: isSelected
                ? TextStyles.text12SemiBold.copyWith(color: AppColors.white)
                : TextStyles.text12Regular
                    .copyWith(color: AppColors.deepNavy.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  /// Builds a scrollable list of days
  Widget _buildDaysList(WidgetRef ref) {
    final state = ref.watch(commonDropdownNotifierProvider);
    final notifier = ref.read(commonDropdownNotifierProvider.notifier);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: GestureDetector(
            onTap: () => notifier.toggleItemSelection(dialogType: dialogType, index: index),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 24, right: 4, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.lightMint.withOpacity(0.8),
                borderRadius: BorderRadius.circular(64),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.reasonName,
                      style: TextStyles.text14SemiBold,
                    ),
                  ),
                  _buildSelectionIndicator(item.isSelected),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds selection indicator (radio button)
  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        isSelected
            ? Assets.images.svg.radioSelected.path
            : Assets.images.svg.radioUnselected.path,
        width: 20,
        height: 20,
        fit: BoxFit.none,
      ),
    );
  }

  /// Builds calendar widget for date selection
  Widget _buildCalendar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.lightMint,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: DateTime.now(),
        headerVisible: true,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerPadding: EdgeInsets.only(bottom: 24),
        ),
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: false,
        ),
        rowHeight: 42,
        onDaySelected: (selectedDay, focusedDay) {
          // Handle day selection
        },
      ),
    );
  }

  /// Builds time wheel picker
  Widget _buildTimeWheelPicker() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Stack(
          children: [
            // Background highlight
            Center(
              child: Row(
                children: [
                  _buildTimeWheelHighlight(),
                  const SizedBox(width: 12),
                  _buildTimeWheelHighlight(),
                  const SizedBox(width: 12),
                  _buildTimeWheelHighlight(),
                ],
              ),
            ),
            // Actual wheel pickers
            Row(children: [
              Flexible(child: _buildTimeWheel()),
              const SizedBox(width: 6),
              Text(":", style: TextStyles.text14Regular),
              const SizedBox(width: 6),
              Flexible(child: _buildTimeWheel()),
              const SizedBox(width: 12),
              Flexible(child: _buildAmPmWheel()),
            ]),
          ],
        ),
      ),
    );
  }

  /// Builds highlight for time wheel picker
  Widget _buildTimeWheelHighlight() {
    return Flexible(
      child: Container(
        width: 90,
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  /// Builds time wheel component
  Widget _buildTimeWheel() {
    // Implement your custom time wheel picker here
    return Container();
  }

  /// Builds AM/PM wheel component
  Widget _buildAmPmWheel() {
    // Implement your custom AM/PM wheel picker here
    return Container();
  }

  /// Builds default list content with optional search
  Widget _buildDefaultListContent(WidgetRef ref) {
    final state = ref.watch(commonDropdownNotifierProvider);
    final notifier = ref.read(commonDropdownNotifierProvider.notifier);

    return Column(
      children: [
        if (state.items.length > 10) ...[
          _buildSearchField(ref),
          const SizedBox(height: 18),
        ],
        Expanded(
          child: _buildScrollableList(ref),
        ),
      ],
    );
  }

  /// Builds search field for large lists
  Widget _buildSearchField(WidgetRef ref) {
    final notifier = ref.read(commonDropdownNotifierProvider.notifier);
    final controller = TextEditingController();
    final focusNode = FocusNode();

    return CustomTextField(
      customTextFieldType: CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD,
      textEditingController: controller,
      focusNode: focusNode,
      hintText: dialogType.searchHint,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      suffixIcon: Assets.images.svg.search.path,
      onTextChanged: (value) {},
    );
  }

  /// Builds a scrollable list of items
  Widget _buildScrollableList(WidgetRef ref) {
    final state = ref.watch(commonDropdownNotifierProvider);
    final notifier = ref.read(commonDropdownNotifierProvider.notifier);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: GestureDetector(
            onTap: () {
              notifier.toggleItemSelection(dialogType: dialogType, index: index);
            },
            child: dialogType ==
                    CommonDropdownSelectionBottomSheetDialogType.SELECT_MONTH
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: item.isSelected
                          ? AppColors.primary
                          : AppColors.lightMint,
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      _getDisplayText(item),
                      style: item.isSelected
                          ? TextStyles.text14SemiBold
                              .copyWith(color: AppColors.white)
                          : TextStyles.text14SemiBold,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                        left: 24, right: 4, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: AppColors.lightMint.withOpacityPrecise(0.8),
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getDisplayText(item),
                            style: TextStyles.text14SemiBold,
                          ),
                        ),
                        _buildSelectionIndicator(item.isSelected),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  /// Gets display text for an item based on dialog type
  String _getDisplayText(dynamic item) {
    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType
            .SELECT_ROUTE_BOOKING_TYPE) {
      return (item as RouteRequestType).title;
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.SELECT_AREA) {
      return (item as DummyCancellationReason).reasonName.orEmpty();
    } else {
      return (item as DummyCancellationReason).reasonName.orEmpty();
    }
  }

  /// Builds add funds to wallet content
  Widget _buildAddFundsToWallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: dialogType.searchHint,
            suffixIcon: SvgPicture.asset(Assets.images.svg.bd.path),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildAmountChip("+BD 10"),
            const SizedBox(width: 8),
            _buildAmountChip("+BD 50"),
            const SizedBox(width: 8),
            _buildAmountChip("+BD 100"),
          ],
        )
      ],
    );
  }

  /// Builds amount selection chip
  Widget _buildAmountChip(String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(58),
      ),
      child: Text(
        amount,
        style: TextStyles.text12SemiBold,
      ),
    );
  }

  /// Builds footer buttons (back and proceed)
  Widget _buildFooterButtons(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonDropdownNotifierProvider);

    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.ADD_FUNDS_TO_WALLET) {
      return CustomTextField(
        customTextFieldType: CustomTextFieldType.BUTTON,
        textEditingController: TextEditingController(),
        focusNode: FocusNode(),
        hintText: dialogType.buttonText,
        keyboardType: TextInputType.none,
        textInputAction: TextInputAction.done,
        suffixIcon: Assets.images.svg.arrowRightGreen.path,
        onPressed: () {
          if (state.selectedId != null) {
            onSelected?.call(state.selectedId!);
          }
          Navigator.pop(context);
        },
      );
    }

    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 52,
            height: 52,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.images.svg.arrowLeft.path,
              fit: BoxFit.none,
            ),
          ),
        ),
        const SizedBox(width: 6),
        // Proceed button
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (state.selectedId != null) {
                onSelected?.call(state.selectedId!);
              }
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 17),
              decoration: BoxDecoration(
                color: AppColors.deepNavy,
                borderRadius: BorderRadius.circular(82),
              ),
              child: Text(
                dialogType.buttonText,
                style:
                    TextStyles.text16SemiBold.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void showCommonDropdownSheet({
    required BuildContext context,
    required CommonDropdownSelectionBottomSheetDialogType dialogType,
    required List<dynamic> items,
    Function(int)? onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CommonDropdownSheet(
          dialogType: dialogType,
          initialItems: items,
          onSelected: onSelected,
        );
      },
      // Transparent background for overlay effect
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
    );
  }
}

/// Enum for different types of dropdown selection dialogs
class CommonDropdownSelectionBottomSheetDialogType {
  final String type;
  final String dialogTitle;
  final String dialogTitleIcon;
  final String searchHint;
  final String buttonText;

  const CommonDropdownSelectionBottomSheetDialogType({
    required this.type,
    required this.dialogTitle,
    required this.dialogTitleIcon,
    required this.searchHint,
    required this.buttonText,
  });

  // Enum values
  static final SELECT_NATIONALITY =
      CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.flag.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_AREA = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_FREQUENCY = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Frequency in Define Booking Rule screen",
    dialogTitle: "Select Frequency",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for frequency",
    buttonText: "Select",
  );

  static final SELECT_YEAR = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Year in Define Booking Rule screen",
    dialogTitle: "Select Year",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for year",
    buttonText: "Select",
  );

  static final SELECT_MONTH = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Month in Define Booking Rule screen",
    dialogTitle: "Select Month Of The Year",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for month",
    buttonText: "Next",
  );

  static final SELECT_SUBJECT = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final CANCELATION_REASON =
      CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_ROUTE_BOOKING_TYPE =
      CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Booking Option",
    dialogTitle: "Select Booking Option",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for booking option",
    buttonText: "Next",
  );

  static final SELECT_SEAT_SELECTION =
      CommonDropdownSelectionBottomSheetDialogType(
    type: "Seat Selection",
    dialogTitle: "Seat Selection",
    dialogTitleIcon: Assets.images.svg.availableSeat16.path,
    searchHint: "Search for seat selection",
    buttonText: "Proceed",
  );

  static final START_DATE = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Start Date",
    dialogTitle: "Select Start Date",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for start date",
    buttonText: "Select",
  );

  static final END_DATE = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select End Date",
    dialogTitle: "Select End Date",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for end date",
    buttonText: "Select",
  );

  static final START_TIME = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Start Time",
    dialogTitle: "Select Start Time",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for start time",
    buttonText: "Select",
  );

  static final DAYS_OF_THE_WEEK = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Days of the Week",
    dialogTitle: "Select Days of the Week",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for days of the week",
    buttonText: "Next",
  );

  static final DAYS_DATES = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Days/Dates",
    dialogTitle: "Select Days/Dates",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for days/dates",
    buttonText: "Next",
  );

  static final ADD_FUNDS_TO_WALLET =
      CommonDropdownSelectionBottomSheetDialogType(
    type: "Add Funds to Wallet",
    dialogTitle: "Add Funds to Wallet",
    dialogTitleIcon: Assets.images.svg.addToWalletWhite.path,
    searchHint: "Enter Amount",
    buttonText: "Add Funds",
  );
}
