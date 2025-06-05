import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/api/model/dummy/dummy_cancellation_reason.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/pages/register/register_controller.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import '../custom/custom_text_filed.dart';

class CommonDropdownSelectionBottomSheet extends StatelessWidget {
  final RxList<DummyCancellationReason> commonList;
  final CommonDropdownSelectionBottomSheetDialogType dialogType;

  const CommonDropdownSelectionBottomSheet(
      {super.key, required this.commonList, required this.dialogType});

  @override
  Widget build(BuildContext context) {
    // Reactive display list
    RxList<DummyCancellationReason> allValueList = <DummyCancellationReason>[].obs;
    allValueList.value = List.from(commonList);
    // ----- [email] -----
    FocusNode emailFocusNode = FocusNode();
    final TextEditingController emailController = TextEditingController();
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height:
              MediaQuery.of(context).size.height * 0.7, // 70% of screen height
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor, // Uses theme background
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Fits content height
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
              CustomTextField(
                customTextFieldType: CustomTextFieldType.SEARCH_FIELD,
                textEditingController: emailController,
                focusNode: emailFocusNode,
                // Moves to password field on next
                hintText: dialogType.searchHint,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                suffixIcon: Assets.images.svg.search.path,
                onTextChanged: (value){
                  if(value.length > 1){
                    allValueList.value = commonList
                        .where((item) => item.reasonName.orEmpty()
                        .toLowerCase()
                        .contains(value.trim().toLowerCase()))
                        .toList();
                  }else if(value.isEmpty){
                    allValueList.value = commonList;
                  }
                },
              ),
              const SizedBox(height: 18),
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
                                      final newList = allValueList.map((item) => item.copyWith(isSelected: false)).toList();
                                      newList[index] = newList[index].copyWith(isSelected: true);
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
                                              allValueList[index]
                                                  .reasonName
                                                  .orEmpty(),
                                              style: TextStyles.text14SemiBold,
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
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                      width: 52,
                      height: 52,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColors.lightBlue, shape: BoxShape.circle),
                      child: SvgPicture.asset(Assets.images.svg.arrowLeft.path,
                          fit: BoxFit.none)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        decoration: BoxDecoration(
                            color: AppColors.deepNavy,
                            borderRadius: BorderRadius.circular(82)),
                        child: Text("Select",
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
    required RxList<DummyCancellationReason> commonList,
  }) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return CommonDropdownSelectionBottomSheet(
          dialogType: dialogType,
          commonList: commonList,
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.transparent,
      // Transparent background for overlay effect
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
    );
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
    type: "Select Nationality in Profile Setup screen",
    dialogTitle: "Select Nationality",
    dialogTitleIcon: Assets.images.svg.uploadImageDialog.path,
    searchHint: "Search for nationality",
    buttonText: "Select",
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
      ];
}
