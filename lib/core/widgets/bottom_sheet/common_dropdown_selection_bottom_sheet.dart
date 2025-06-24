import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/api/model/dummy/dummy_cancellation_reason.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/pages/register/register_controller.dart';

import '../../../api/model/static/route_request_type.dart';
import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import '../custom/custom_text_filed.dart';

class CommonDropdownSelectionBottomSheet extends StatelessWidget {
  final RxList<dynamic> commonList;
  final CommonDropdownSelectionBottomSheetDialogType dialogType;
  final VoidCallback? onTap;

  const CommonDropdownSelectionBottomSheet(
      {super.key,
      required this.commonList,
      required this.dialogType,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    // Reactive display list
    RxList<dynamic> allValueList = <dynamic>[].obs;
    allValueList.value = List.from(commonList);
    RxList<dynamic> searchItemList = <dynamic>[].obs;
    searchItemList.value = List.from(commonList);
    // ----- [email] -----
    FocusNode emailFocusNode = FocusNode();
    final TextEditingController emailController = TextEditingController();
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: MediaQuery.of(context).size.height *
              (dialogType ==
                      CommonDropdownSelectionBottomSheetDialogType
                          .SELECT_SEAT_SELECTION
                  ? 0.37
                  : dialogType ==
                          CommonDropdownSelectionBottomSheetDialogType
                              .SELECT_ROUTE_BOOKING_TYPE
                      ? 0.4
                      : 0.7),
          // 70% of screen height
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor, // Uses theme background
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min, // Fits content height
            children: [
              // ======================
              // Header Section (Title + Icon)
              // ======================
              Row(
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
              ),
              const SizedBox(height: 24),
              if (dialogType ==
                  CommonDropdownSelectionBottomSheetDialogType
                      .SELECT_SEAT_SELECTION) ...[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildNumberOfSeatsCard(),
                      const SizedBox(height: 14),
                      Text(
                        "Select the total number of seats required for\nyour Booking",
                        style: TextStyles.text12Regular
                            .copyWith(fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                )
              ] else if (dialogType ==
                  CommonDropdownSelectionBottomSheetDialogType.SELECT_AREA) ...[
                Text("data")
              ] else ...[
                if (commonList.length > 10) ...[
                  CustomTextField(
                    customTextFieldType:
                        CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD,
                    textEditingController: emailController,
                    focusNode: emailFocusNode,
                    // Moves to password field on next
                    hintText: dialogType.searchHint,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    suffixIcon: Assets.images.svg.search.path,
                    onTextChanged: (value) {},
                  ),
                  const SizedBox(height: 18)
                ],
                Expanded(
                  child: Obx(() => CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (_, index) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: GestureDetector(
                                      onTap: () {
                                        final item = allValueList[index];
                                        final position = commonList.indexWhere(
                                            (it) => it.id == item.id);
                                        final newList = allValueList
                                            .map((bean) => bean.copyWith(
                                                isSelected: false))
                                            .toList();
                                        newList[index] = newList[index]
                                            .copyWith(isSelected: true);
                                        allValueList.value = newList;
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 24,
                                              right: 4,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightMint
                                                .withOpacityPrecise(0.8),
                                            borderRadius:
                                                BorderRadius.circular(64),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                _getDisplayText(
                                                    allValueList[index]),
                                                style:
                                                    TextStyles.text14SemiBold,
                                              )),
                                              Container(
                                                width: 44,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    shape: BoxShape.circle),
                                                child: SvgPicture.asset(
                                                  allValueList[index].isSelected
                                                      ? Assets.images.svg
                                                          .radioSelected.path
                                                      : Assets.images.svg
                                                          .radioUnselected.path,
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.none,
                                                ),
                                              )
                                            ],
                                          )),
                                    )),
                                childCount: allValueList.length,
                              ),
                            )
                          ])),
                ),
              ],
              const SizedBox(height: 18),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTap?.call();
                    },
                    child: Container(
                        width: 52,
                        height: 52,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: AppColors.lightBlue, shape: BoxShape.circle),
                        child: SvgPicture.asset(
                            Assets.images.svg.arrowLeft.path,
                            fit: BoxFit.none)),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        decoration: BoxDecoration(
                            color: AppColors.deepNavy,
                            borderRadius: BorderRadius.circular(82)),
                        child: Text(dialogType.buttonText,
                            style: TextStyles.text16SemiBold
                                .copyWith(color: AppColors.white))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// general bottom sheet with two button
  static void showBottomSheet({
    required CommonDropdownSelectionBottomSheetDialogType dialogType,
    required RxList<dynamic> commonList,
    VoidCallback? onTap,
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

  /// Build number of seats card
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
                SvgPicture.asset(
                  Assets.images.svg.minus.path,
                  fit: BoxFit.none,
                ),
                Text(
                  "3",
                  style: TextStyles.text14SemiBold.copyWith(
                      color: AppColors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.white,
                      decorationStyle: TextDecorationStyle.solid),
                ),
                SvgPicture.asset(
                  Assets.images.svg.plus.path,
                  fit: BoxFit.none,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

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
}

// CommonDropdownSelectionBottomSheetDialogType class
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
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
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

// Helper to get all values (optional)
  static List<CommonDropdownSelectionBottomSheetDialogType> get values => [
        SELECT_NATIONALITY,
        SELECT_AREA,
        SELECT_FREQUENCY,
        SELECT_YEAR,
        SELECT_SUBJECT,
        CANCELATION_REASON,
        SELECT_ROUTE_BOOKING_TYPE,
        SELECT_SEAT_SELECTION
      ];
}
