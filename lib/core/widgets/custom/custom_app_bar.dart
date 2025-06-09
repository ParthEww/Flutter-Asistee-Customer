import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';
import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackButtonTap;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.onBackButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(
            onBackButtonTap: () {
              onBackButtonTap?.call();
            },
          ),
          Text(
            title,
            style: TextStyles.text18SemiBold.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
