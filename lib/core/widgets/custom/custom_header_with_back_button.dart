import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomHeaderWithBackButton extends StatelessWidget {
  final String title;
  final String description;
  final bool isShowBackButton;
  final VoidCallback? onBackButtonTap;

  const CustomHeaderWithBackButton(
      {super.key,
      required this.title,
      required this.description,
      this.isShowBackButton = false,
      this.onBackButtonTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowBackButton) ...[
          CustomBackButton(
            onBackButtonTap: () {
              onBackButtonTap?.call();
            },
          ),
          SizedBox(height: 18),
        ],
        Text(
          title,
          style: TextStyles.text32SemiBold,
        ),
        SizedBox(height: 12),
        Text(
          description,
          style: TextStyles.text14Regular
              .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.4)),
        ),
      ],
    );
  }
}
