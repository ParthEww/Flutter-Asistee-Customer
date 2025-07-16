import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';

class AppTextFieldRequiredLabel extends StatelessWidget {
  final String label;
  final bool showRequiredMark;
  final bool showRequiredMarkOnFront;
  final bool showUnderLine;
  final Color labelColor;
  final Color requireLabelColor;

  const AppTextFieldRequiredLabel({
    super.key,
    required this.label,
    this.showRequiredMark = false,
    this.showRequiredMarkOnFront = true,
    this.showUnderLine = false,
    this.labelColor = AppColors.deepNavy,
    this.requireLabelColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          if (showRequiredMark && showRequiredMarkOnFront) ...[
            TextSpan(
              text: '*',
              style: TextStyles.text12SemiBold.copyWith(
                color: requireLabelColor,
              ),
            )
          ],
          TextSpan(
            text: label,
            style: TextStyles.text12SemiBold.copyWith(
                color: labelColor,
                decoration: showUnderLine ? TextDecoration.underline : null),
          ),
          if (showRequiredMark && !showRequiredMarkOnFront) ...[
            TextSpan(
              text: '*',
              style: TextStyles.text12SemiBold.copyWith(
                color: requireLabelColor,
              ),
            )
          ]
        ],
      ),
    );
  }
}
