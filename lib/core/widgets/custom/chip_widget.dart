import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_yay_rider_driver/core/themes/app_colors.dart';
import 'package:flutter_yay_rider_driver/core/themes/text_styles.dart';
import 'package:flutter_yay_rider_driver/gen/assets.gen.dart';

class ChipWidget extends StatelessWidget {
  final String? title;
  const ChipWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Increased padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Slightly larger radius
        color: AppColors.gray100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title!,
            style: TextStyles.text14Medium.copyWith(
              color: AppColors.primary, // Better contrast
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(Assets.images.svg.deleteAddress.path)
        ],
      ),
    );
  }

}
