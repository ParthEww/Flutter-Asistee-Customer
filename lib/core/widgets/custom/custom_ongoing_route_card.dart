import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_yay_rider_driver/core/themes/app_colors.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/text_styles.dart';
import 'custom_circle_icon.dart';

class CustomOngoingRouteCard extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String viaText;
  final String dateRange;
  final String startTime;
  final String endTime;
  final String repeatText;
  final String distanceDuration;
  final String routeNumber;
  final bool isOnboard;
  final VoidCallback onTap;

  const CustomOngoingRouteCard({
    super.key,
    required this.startLocation,
    required this.endLocation,
    required this.viaText,
    required this.dateRange,
    required this.startTime,
    required this.endTime,
    required this.repeatText,
    required this.distanceDuration,
    required this.routeNumber,
    required this.isOnboard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 18, top: 18, right: 18, bottom: 18),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacityPrecise(0.14),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCircleIcon(
                      iconPath: Assets.images.svg.route16.path,
                    padding: const EdgeInsets.all(8),
                    backgroundColor: AppColors.deepNavy,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      "Route No. $routeNumber",
                      style: TextStyles.text12SemiBold.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                  Text(
                    dateRange,
                    style: TextStyles.text12SemiBold.copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.6)),
                  )
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          startLocation,
                          style: TextStyles.text18SemiBold
                              .copyWith(color: AppColors.deepNavy),
                        ),
                        Text(
                          startTime,
                          style: TextStyles.text12Regular
                              .copyWith(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(Assets.images.svg.line3.path),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          decoration: const BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.all(Radius.circular(51)),
                          ),
                          child: Text(
                            "$distanceDuration Hrs",
                            style: TextStyles.text12SemiBold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          endLocation,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.text18SemiBold
                              .copyWith(color: AppColors.deepNavy),
                        ),
                        Text(
                          endTime,
                          style: TextStyles.text12Regular
                              .copyWith(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            _buildFooterRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterRow() {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 4, right: 4, bottom: 4),
      decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(24))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
                isOnboard ? "Arrived at Pickup Point" : "Trip Started",
                style: TextStyles.text14SemiBold.copyWith(color: AppColors.white),
              )),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: isOnboard ? 35 : 18),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(21)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!isOnboard) ...[
                  SvgPicture.asset(Assets.images.svg.bus18.path),
                  const SizedBox(width: 8)
                ],
                Text(
                  isOnboard ? "Onboard" : "Track Trip",
                  style: TextStyles.text12SemiBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
