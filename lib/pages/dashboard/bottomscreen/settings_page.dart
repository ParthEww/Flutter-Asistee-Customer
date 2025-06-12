import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/custom/custom_circle_icon.dart';
import 'package:project_structure/gen/assets.gen.dart';

import '../../../core/themes/app_colors.dart';
import '../dashboard_controller.dart';

class SettingsPage extends GetView<DashboardController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderSection(
              onEditProfileCallBack: (){
                controller.onGoToEditProfile();
              }
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        buildFirstSettingsSection(),
                        const SizedBox(height: 16),
                        buildSecondSettingsSection(),
                        const SizedBox(height: 16),
                        buildThirdSettingsSection(),
                        const SizedBox(height: 32),
                        Text(
                          "App Version 1.0.0",
                          style: TextStyles.text12SemiBold.copyWith(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 18)
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeaderSection({required VoidCallback onEditProfileCallBack}){
    return Container(
      height: Get.height * 0.35,
      color: AppColors.white,
      child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              width: Get.width,
              height: Get.height * 0.35 * 0.5,
              child: Container(
                color: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyles.text24SemiBold.copyWith(color: AppColors.white),
                      ),
                      SvgPicture.asset(
                        Assets.images.svg.profileSettings.path,
                        fit: BoxFit.none,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: Get.width,
              height: Get.height * 0.3 * 0.3,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Parth Patel",
                        style: TextStyles.text18SemiBold.copyWith(color: AppColors.deepNavy),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "parth@yopmail.com",
                        style: TextStyles.text12Medium.copyWith(color: AppColors.primary.withOpacityPrecise(0.6)),
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                            color: AppColors.white,
                            width: 6
                        )
                    ),
                    child: Container(
                      width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Image.asset(
                          Assets.images.png.dummyProfileImage.path,
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                            color: AppColors.white,
                            width: 6
                        )
                    ),
                    child: GestureDetector(
                      onTap: onEditProfileCallBack,
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 4, top: 4, right: 12, bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCircleIcon(
                                iconPath: Assets.images.svg.editPen.path,
                                padding: const EdgeInsets.only(left: 7, top: 7, right: 9, bottom: 9),
                                backgroundColor: AppColors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Edit Profile",
                                style: TextStyles.text12SemiBold,
                              )
                            ],
                          )
                      ),
                    ),
                  )
                ],
              ),
            )
          ]
      ),
    );
  }

  Widget buildFirstSettingsSection(){
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.all(Radius.circular(32))
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
        controller.firstSettingsList.length,
        itemBuilder:
            (BuildContext context, int index) {
          return buildSettingsView(controller.firstSettingsList[index]);
        },
        separatorBuilder:
            (BuildContext context, int index) {
          return Column(
            children: [
              Divider(
                height: 2,
                thickness: 2,
                color: AppColors.secondary.withOpacityPrecise(0.4), // Customize color
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildSecondSettingsSection(){
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.all(Radius.circular(32))
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
        controller.secondSettingsList.length,
        itemBuilder:
            (BuildContext context, int index) {
          return buildSettingsView(controller.secondSettingsList[index]);
        },
        separatorBuilder:
            (BuildContext context, int index) {
          return Column(
            children: [
              Divider(
                height: 2,
                thickness: 2,
                color: AppColors.secondary.withOpacityPrecise(0.4), // Customize color
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildThirdSettingsSection(){
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.all(Radius.circular(32))
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
        controller.thirdSettingsList.length,
        itemBuilder:
            (BuildContext context, int index) {
          return buildSettingsView(controller.thirdSettingsList[index]);
        },
        separatorBuilder:
            (BuildContext context, int index) {
          return Column(
            children: [
              Divider(
                height: 2,
                thickness: 2,
                color: AppColors.secondary.withOpacityPrecise(0.4), // Customize color
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildSettingsView(SettingFieldType bean){
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 18, right: 24, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCircleIcon(
            iconPath: bean.icon,
            padding: const EdgeInsets.all(11),
            backgroundColor: bean == SettingFieldType.DELETE_ACCOUNT ? AppColors.green : AppColors.primary,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  bean.title,
                  style: TextStyles.text16SemiBold.copyWith(color: AppColors.deepNavy),
                ),
                if (bean == SettingFieldType.ADMIN_CHAT) ...[
                  const SizedBox(width: 10),
                  Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.deepNavy,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                          "2",
                          style: TextStyles.text12SemiBold.copyWith(color: AppColors.white),
                        )
                    ),
                  )
                ],
              ],
            ),
          ),
          SvgPicture.asset(
            Assets.images.svg.arrowRightGreen.path,
            fit: BoxFit.none,
          )
        ],
      ),
    );
  }
}