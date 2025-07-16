import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';

class PriceText extends StatelessWidget {
  final String amount;
  final TextStyle parentTextStyle;
  final TextStyle childTextStyle;
  final Color parentTextColor;
  final Color childTextColor;

  const PriceText({
    super.key,
    required this.amount,
    required this.parentTextStyle,
    required this.childTextStyle,
    required this.parentTextColor,
    required this.childTextColor
  });

  @override
  Widget build(BuildContext context) {
    final parts = amount.split('.');

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${parts[0]}.',
            style: parentTextStyle.copyWith(color: parentTextColor),
          ),
          TextSpan(
            text: parts[1],
            style: childTextStyle.copyWith(color: childTextColor),
          ),
        ],
      ),
    );
  }
}
