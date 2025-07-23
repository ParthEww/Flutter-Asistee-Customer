import 'package:flutter/cupertino.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';

import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomAuthHeaderWithBackButton extends StatelessWidget {
  final String title;
  final String description;
  final bool isShowBackButton;
  final VoidCallback? onBackButtonTap;

  const CustomAuthHeaderWithBackButton(
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
          const SizedBox(height: 18),
        ],
        Text(
          title,
          style: TextStyles.text32SemiBold,
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: TextStyles.text14Regular
              .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.4)),
        ),
      ],
    );
  }
}
