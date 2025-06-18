import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';

class AppTextFieldRequiredLabel extends StatelessWidget {
  final String label;
  final bool showRequiredMark;

  const AppTextFieldRequiredLabel({
    super.key,
    required this.label,
    this.showRequiredMark = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          if (showRequiredMark) ...[
            TextSpan(
              text: '*',
              style: TextStyles.text12SemiBold.copyWith(
                color: AppColors.primary,
              ),
            )
          ],
          TextSpan(
            text: label,
            style: TextStyles.text12SemiBold.copyWith(
              color: AppColors.deepNavy.withOpacityPrecise(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
