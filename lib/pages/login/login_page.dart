import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 40,
          bottom: 16,
        ),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                      Assets.images.svg.asisteeLogoWithText.path,
                      width: 80,
                      height: 58,
                      fit: BoxFit.contain),
                ),
                Positioned(
                    right: 0,
                    child: CustomTagButton(
                      text: "Guest User",
                      onTap: () {},
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  "Sign In to Asistee",
                  style: TextStyles.displayXsBold,
                ),
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  "Enter your Number below to get into the\nAsistee Customer app ",
                  style: TextStyles.textSmRegular
                      .copyWith(color: AppColors.secondary.withAlpha(153)),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 13),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Text(
                        "+91",
                        style: TextStyles.textSmMedium
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: CustomTextField(
                      customTextFieldType: CustomTextFieldType.PHONE_NUMBER,
                      textEditingController: controller.phoneNumberController,
                      focusNode: controller.phoneNumberFocusNode,
                      nextFocusNode: controller.passwordFocusNode,
                      labelText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      suffixIcon: SvgPicture.asset(
                        Assets.images.svg.call.path,
                        width: 20,
                        height: 20,
                        fit: BoxFit.none,
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  customTextFieldType: CustomTextFieldType.PASSWORD,
                  textEditingController: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  labelText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: SvgPicture.asset(
                    Assets.images.svg.passwordCheck.path,
                    width: 20,
                    height: 20,
                    fit: BoxFit.none,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyles.textSmRegular
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 40),
                AppButton(
                  buttonText: "Sign In",
                  onPressed: () {},
                  buttonRadius: 16,
                  buttonHeight: 56,
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonColor: AppColors.black,
                  textColor: AppColors.white,
                  textFontFamily: FontFamily.lufga,
                  textFontSize: 16,
                  textFontWeight: FontWeight.w700,
                )
              ],
            ),
          )
        ]),
      )),
    );
  }
}
