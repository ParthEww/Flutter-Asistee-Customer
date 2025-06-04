import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';

class AppTextFieldLabel extends StatelessWidget {
  final String label;
  final String clickableLabel;
  final Function() onTap;

  const AppTextFieldLabel({
    super.key,
    required this.label,
    required this.clickableLabel,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "$label ",
        style: TextStyles.text14Medium.copyWith(color: AppColors.deepNavy),
        children: [
          TextSpan(
            text: clickableLabel,
            style: TextStyles.text14Bold.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline
            ),
            recognizer: TapGestureRecognizer()..onTap = (){
              onTap.call();
            }
          )
        ],
      ),
    );
  }
}
