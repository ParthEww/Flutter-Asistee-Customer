import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

// Enum for Days/Dates selection type
enum DaysDatesType {
  DAYS(title: "Repeat on Days", isSelected: true),
  DATES(title: "Repeat on Dates", isSelected: false);

  final String title;
  final bool isSelected;

  const DaysDatesType({required this.title, required this.isSelected});
}

/// A customizable bottom sheet for dropdown selection with various types
class CommonDropdownSelectionBottomSheet extends StatelessWidget {
  final RxList<dynamic> commonList;
  final CommonDropdownSelectionBottomSheetDialogType dialogType;
  final Function(CommonDropdownSelectionBottomSheetDialogType, int)? onTap;

  const CommonDropdownSelectionBottomSheet({
    super.key,
    required this.commonList,
    required this.dialogType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Reactive variables for the list and selection state
    RxList<dynamic> allValueList = <dynamic>[].obs;
    allValueList.value = List.from(commonList);
    RxList<dynamic> searchItemList = <dynamic>[].obs;
    searchItemList.value = List.from(commonList);
    Rx<DaysDatesType> isDaysTypeSelected = DaysDatesType.DAYS.obs;

    // UI controllers and focus nodes
    FocusNode emailFocusNode = FocusNode();
    final TextEditingController emailController = TextEditingController();

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
              // --------------------------
              // Header Section (Title + Icon)
              // --------------------------
              _buildHeaderSection(),
              const SizedBox(height: 24),

              // --------------------------
              // Main Content Section
              // --------------------------
              Expanded(
                child: _buildMainContentSection(
                  context,
                  allValueList,
                  isDaysTypeSelected,
                  emailController,
                  emailFocusNode,
                ),
              ),
              const SizedBox(height: 18),

              // --------------------------
              // Footer Buttons
              // --------------------------
              _buildFooterButtons(allValueList),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // Helper Methods
  // ========================================================================

  /// Calculates the appropriate height based on dialog type
  double _calculateDialogHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.SELECT_SEAT_SELECTION) {
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
          decoration: BoxDecoration(
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
          style: TextStyles.text14SemiBold,
        ),
      ],
    );
  }

  /// Builds the main content section based on dialog type
  Widget _buildMainContentSection(
      BuildContext context,
      RxList<dynamic> allValueList,
      Rx<DaysDatesType> isDaysTypeSelected,
      TextEditingController emailController,
      FocusNode emailFocusNode,
      ) {
    if (dialogType == CommonDropdownSelectionBottomSheetDialogType.SELECT_SEAT_SELECTION) {
      return _buildSeatSelectionContent();
    } else if (dialogType == CommonDropdownSelectionBottomSheetDialogType.START_DATE ||
        dialogType == CommonDropdownSelectionBottomSheetDialogType.END_DATE) {
      return Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 22),
        ],
      );
    } else if (dialogType == CommonDropdownSelectionBottomSheetDialogType.START_TIME) {
      return Column(
        children: [
          _buildTimeWheelPicker(),
          const SizedBox(height: 22),
        ],
      );
    } else if (dialogType == CommonDropdownSelectionBottomSheetDialogType.DAYS_DATES) {
      return _buildDaysDatesContent(allValueList, isDaysTypeSelected);
    } else {
      return _buildDefaultListContent(allValueList, emailController, emailFocusNode);
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
            style: TextStyles.text12Regular.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  /// Builds content for days/dates selection type
  Widget _buildDaysDatesContent(
      RxList<dynamic> allValueList,
      Rx<DaysDatesType> isDaysTypeSelected,
      ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRepeatOnView(
                daysDatesType: DaysDatesType.DAYS,
                selectedDayDateType: isDaysTypeSelected,
              ),
              const SizedBox(width: 12),
              _buildRepeatOnView(
                daysDatesType: DaysDatesType.DATES,
                selectedDayDateType: isDaysTypeSelected,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Obx(() {
              return isDaysTypeSelected.value == DaysDatesType.DAYS
                  ? _buildDaysList(allValueList)
                  : _buildCalendar();
            }),
          ),
        ],
      ),
    );
  }

  /// Builds the default list content with optional search
  Widget _buildDefaultListContent(
      RxList<dynamic> allValueList,
      TextEditingController emailController,
      FocusNode emailFocusNode,
      ) {
    return Column(
      children: [
        if (commonList.length > 10) ...[
          CustomTextField(
            customTextFieldType: CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD,
            textEditingController: emailController,
            focusNode: emailFocusNode,
            hintText: dialogType.searchHint,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            suffixIcon: Assets.images.svg.search.path,
            onTextChanged: (value) {},
          ),
          const SizedBox(height: 18),
        ],
        Expanded(
          child: Obx(() => _buildScrollableList(allValueList)),
        ),
      ],
    );
  }

  /// Builds a scrollable list of items
  Widget _buildScrollableList(RxList<dynamic> allValueList) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (_, index) => _buildListItem(allValueList[index], allValueList),
            childCount: allValueList.length,
          ),
        ),
      ],
    );
  }

  /// Builds a scrollable list of days
  Widget _buildDaysList(RxList<dynamic> allValueList) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (_, index) => _buildListItem(allValueList[index], allValueList),
            childCount: allValueList.length,
          ),
        ),
      ],
    );
  }

  /// Builds individual list items
  Widget _buildListItem(dynamic item, RxList<dynamic> allValueList) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: GestureDetector(
        onTap: () => _handleItemSelection(item, allValueList),
        child: Container(
          padding: const EdgeInsets.only(left: 24, right: 4, top: 4, bottom: 4),
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
              _buildSelectionIndicator(item),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the selection indicator (radio/checkbox) based on dialog type
  Widget _buildSelectionIndicator(dynamic item) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        _getSelectionIconPath(item),
        width: 20,
        height: 20,
        fit: BoxFit.none,
      ),
    );
  }

  /// Builds the footer buttons (back and proceed)
  Widget _buildFooterButtons(RxList<dynamic> allValueList) {
    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 52,
            height: 52,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
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
            onTap: () => _handleProceedButton(allValueList),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 17),
              decoration: BoxDecoration(
                color: AppColors.deepNavy,
                borderRadius: BorderRadius.circular(82),
              ),
              child: Text(
                dialogType.buttonText,
                style: TextStyles.text16SemiBold.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ========================================================================
  // Component Builders
  // ========================================================================

  /// Builds number of seats card
  Widget _buildNumberOfSeatsCard() {
    return Container(
      width: Get.width,
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
                SvgPicture.asset(Assets.images.svg.minus.path, fit: BoxFit.none),
                Text(
                  "3",
                  style: TextStyles.text14SemiBold.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                    decorationStyle: TextDecorationStyle.solid,
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

  /// Builds calendar widget
  Widget _buildCalendar() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.lightMint,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        headerVisible: true,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerPadding: EdgeInsets.only(bottom: 24),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: false,
        ),
        rowHeight: 42,
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) => _buildCalendarHeader(day),
          defaultBuilder: (context, day, focusedDay) => _buildCalendarDay(day),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyles.text12Medium
              .copyWith(color: AppColors.primary.withOpacityPrecise(0.4)),
          weekendStyle: TextStyles.text12Medium
              .copyWith(color: AppColors.primary.withOpacityPrecise(0.4)),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          print("day tap");
        },
      ),
    );
  }

  /// Builds calendar header
  Widget _buildCalendarHeader(DateTime day) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(21),
            ),
            child: Text(
              AppMethods.convertDateTimeToString(
                  day, AppMethods.FORMAT_MMMM_YYYY),
              style: TextStyles.text14SemiBold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(21),
          ),
          child: Row(
            children: [
              Transform.rotate(
                angle: pi,
                child: CustomCircleIcon(
                  iconPath: Assets.images.svg.arrowRight18.path,
                  padding: const EdgeInsets.all(7),
                  backgroundColor: AppColors.white,
                ),
              ),
              const SizedBox(width: 6),
              CustomCircleIcon(
                iconPath: Assets.images.svg.arrowRight18.path,
                padding: const EdgeInsets.all(7),
                backgroundColor: AppColors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds individual calendar day
  Widget _buildCalendarDay(DateTime day) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacityPrecise(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${day.day}",
        style: TextStyles.text14Regular.copyWith(color: AppColors.deepNavy),
      ),
    );
  }

  /// Builds time wheel picker
  Widget _buildTimeWheelPicker() {
    return Expanded(
      child: Container(
        width: Get.width,
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
              Flexible(
                child: CustomTimeWheelPicker(
                    wheelPickerType: WheelPickerType.HOUR),
              ),
              const SizedBox(width: 6),
              Text(":", style: TextStyles.text14Regular),
              const SizedBox(width: 6),
              Flexible(
                child: CustomTimeWheelPicker(
                    wheelPickerType: WheelPickerType.MINUTE),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: CustomTimeWheelPicker(
                    wheelPickerType: WheelPickerType.AM_PM),
              ),
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

  /// Builds days/dates toggle view
  Widget _buildRepeatOnView({
    required DaysDatesType daysDatesType,
    required Rx<DaysDatesType> selectedDayDateType,
  }) {
    return Obx(() => Expanded(
      child: GestureDetector(
        onTap: () => selectedDayDateType.value = daysDatesType,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: selectedDayDateType.value == daysDatesType
                ? AppColors.primary
                : AppColors.lightBlue,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            daysDatesType.title,
            style: selectedDayDateType.value == daysDatesType
                ? TextStyles.text12SemiBold.copyWith(color: AppColors.white)
                : TextStyles.text12Regular.copyWith(
                color: AppColors.deepNavy.withOpacityPrecise(0.5)),
          ),
        ),
      ),
    ));
  }

  // ========================================================================
  // Helper Methods
  // ========================================================================

  /// Gets display text for an item based on dialog type
  String _getDisplayText(dynamic item) {
    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.SELECT_ROUTE_BOOKING_TYPE) {
      return (item as RouteRequestType).title;
    } else if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.SELECT_AREA) {
      return (item as DummyCancellationReason).reasonName.orEmpty();
    } else {
      return (item as DummyCancellationReason).reasonName.orEmpty();
    }
  }

  /// Gets the appropriate selection icon path based on dialog type and selection state
  String _getSelectionIconPath(dynamic item) {
    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.DAYS_OF_THE_WEEK) {
      return item.isSelected
          ? Assets.images.svg.checkBoxChecked.path
          : Assets.images.svg.checkBoxUnchecked.path;
    } else {
      return item.isSelected
          ? Assets.images.svg.radioSelected.path
          : Assets.images.svg.radioUnselected.path;
    }
  }

  /// Handles item selection
  void _handleItemSelection(dynamic item, RxList<dynamic> allValueList) {
    final position = commonList.indexWhere((it) => it.id == item.id);
    final newList = allValueList
        .map((bean) => bean.copyWith(isSelected: false))
        .toList();
    newList[position] = newList[position].copyWith(isSelected: true);
    allValueList.value = newList;
  }

  /// Handles proceed button tap
  void _handleProceedButton(RxList<dynamic> allValueList) {
    print(allValueList
        .firstWhereOrNull((element) => element.isSelected)
        ?.id);
    onTap?.call(
      dialogType,
      allValueList
          .firstWhereOrNull((element) => element.isSelected)
          ?.id,
    );
    Get.back();
  }

  // ========================================================================
  // Static Methods
  // ========================================================================

  /// Shows the bottom sheet dialog
  static void showBottomSheet({
    required CommonDropdownSelectionBottomSheetDialogType dialogType,
    required RxList<dynamic> commonList,
    Function(CommonDropdownSelectionBottomSheetDialogType, int)? onTap,
  }) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return CommonDropdownSelectionBottomSheet(
            dialogType: dialogType, commonList: commonList, onTap: onTap);
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
  static final SELECT_NATIONALITY = CommonDropdownSelectionBottomSheetDialogType(
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
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_SUBJECT = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final CANCELATION_REASON = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
  );

  static final SELECT_ROUTE_BOOKING_TYPE = CommonDropdownSelectionBottomSheetDialogType(
    type: "Select Booking Option",
    dialogTitle: "Select Booking Option",
    dialogTitleIcon: Assets.images.svg.calendar16.path,
    searchHint: "Search for booking option",
    buttonText: "Next",
  );

  static final SELECT_SEAT_SELECTION = CommonDropdownSelectionBottomSheetDialogType(
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
}
