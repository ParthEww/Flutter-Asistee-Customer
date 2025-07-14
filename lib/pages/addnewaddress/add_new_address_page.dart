import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_structure/api/model/static/address_type.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/custom/custom_app_bar.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:project_structure/services/google_place/google_place_model.dart';
import 'package:retrofit/http.dart';

import '../../core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import 'add_new_address_controller.dart';

class AddNewAddressPage extends GetView<AddNewAddressController> {
  const AddNewAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Add Address',
              onBackButtonTap: () {
                Get.back();
              },
            ),
            Expanded(
              child: Obx(() {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      initialCameraPosition: controller.cameraPosition.value!,
                      onMapCreated: controller.mapController.call,
                    ),
                    Positioned.fill(
                        child: DraggableScrollableSheet(
                      initialChildSize: 0.84,
                      minChildSize: 0.84,
                      maxChildSize: 0.84,
                      expand: false,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(44),
                                  topRight: Radius.circular(44)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address Type",
                                  style: TextStyles.text14SemiBold,
                                ),
                                SizedBox(height: 14),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: controller.addressTypeList
                                      .map(
                                        (item) =>
                                        _buildAddressType(
                                            item,
                                            controller.addressTypeList
                                                .indexOf(item)),
                                  )
                                      .toList(),
                                ),
                                SizedBox(height: 32),
                                Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                      controller.addressFiledList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CustomTextField(
                                          customTextFieldType: CustomTextFieldType.ADDRESS_FIELD,
                                          textEditingController: controller.addressFiledList[index].textEditingController,
                                          focusNode: controller.addressFiledList[index].focusNode,
                                          nextFocusNode: index == controller.addressFiledList.lastIndex ? null : controller.addressFiledList[index + 1].focusNode,
                                          // Moves to area field on next
                                          hintText: controller.addressFiledList[index].hint,
                                          keyboardType: TextInputType.text,
                                          textInputAction: index == controller.addressFiledList.lastIndex ? TextInputAction.done : TextInputAction.next,
                                          suffixIcon: controller.addressFiledList[index].icon,
                                          onTextChanged: (value) {
                                            controller.addressFiledList[index].text = value;
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(height: 14);
                                      },
                                    )
                                ),
                                const SizedBox(height: 32),
                                CustomTextField(
                                  customTextFieldType: CustomTextFieldType.BUTTON,
                                  textEditingController: TextEditingController(),
                                  focusNode: FocusNode(),
                                  hintText: "Submit",
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  suffixIcon: Assets.images.svg.arrowRightGreen.path,
                                  onPressed: () {
                                    Get.back();
                                  }, // TODO: Add sign in functionality
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressType(AddressType bean, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.only(left: 4, top: 4, right: 14, bottom: 4),
          decoration: BoxDecoration(
            color: bean.is_selected ? AppColors.primary : AppColors.lightBlue,
            borderRadius: BorderRadius.circular(66),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: SvgPicture.asset(bean.image_path),
              ),
            ),
            SizedBox(width: 8),
            Text(
              bean.title,
              style: TextStyles.text14SemiBold.copyWith(
                  color:
                      bean.is_selected ? AppColors.white : AppColors.primary),
            )
          ])),
    );
  }
}
