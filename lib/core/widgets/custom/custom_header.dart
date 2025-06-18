import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isShowBackButton;
  final bool isShowSubtitle;
  final VoidCallback? onBackButtonTap;

  const CustomHeader(
      {super.key,
      required this.title,
      required this.subTitle,
      this.isShowBackButton = false,
      this.isShowSubtitle = false,
      this.onBackButtonTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 22, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isShowBackButton) ...[
            CustomBackButton(onBackButtonTap: () {
              onBackButtonTap?.call();
            })
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyles.text18SemiBold
                      .copyWith(color: AppColors.white),
                ),
                if (isShowSubtitle) ...[
                  Text(
                    subTitle,
                    style: TextStyles.text12SemiBold.copyWith(
                      color: AppColors.white.withOpacityPrecise(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
