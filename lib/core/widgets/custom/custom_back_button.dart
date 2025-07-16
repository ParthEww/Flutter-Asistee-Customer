import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onBackButtonTap;

  const CustomBackButton({super.key, required this.onBackButtonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onBackButtonTap.call();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 18, vertical: 4),
          width: 60,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: const BorderRadius.all(Radius.circular(19)),
          ),
          child: SvgPicture.asset(
            Assets.images.svg.arrowLeft.path,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          )
      ),
    );
  }
}
