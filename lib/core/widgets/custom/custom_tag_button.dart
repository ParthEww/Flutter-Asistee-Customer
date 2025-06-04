import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

class CustomTagButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomTagButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(text,
              style: TextStyles.text12Medium.apply(color: AppColors.white)),
          const SizedBox(width: 7),
          SvgPicture.asset(Assets.images.svg.doubleArrowRight.path,
              fit: BoxFit.cover),
        ]));
  }
}
