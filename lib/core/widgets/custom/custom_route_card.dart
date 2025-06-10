import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/text_styles.dart';
import 'custom_circle_icon.dart';

class CustomRouteCard extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String viaText;
  final String dateRange;
  final String timeRange;
  final String repeatText;
  final String distanceDuration;
  final String routeNumber;

  const CustomRouteCard({
    Key? key,
    required this.startLocation,
    required this.endLocation,
    required this.viaText,
    required this.dateRange,
    required this.timeRange,
    required this.repeatText,
    required this.distanceDuration,
    required this.routeNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightMint,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with locations
                _buildLocationRow(),
                const SizedBox(height: 7),
                // Details Stack with timeline
                _buildDetailsStack(),
              ],
            ),
          ),
          // Footer with distance and route number
          _buildFooterRow(),
        ],
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCircleIcon(
          iconPath: Assets.images.svg.route20.path,
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.deepNavy,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      startLocation,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.text16SemiBold
                          .copyWith(color: AppColors.deepNavy),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SvgPicture.asset(
                    Assets.images.svg.arrowRightGreen.path,
                    fit: BoxFit.none,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      endLocation,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.text16SemiBold
                          .copyWith(color: AppColors.deepNavy),
                    ),
                  ),
                ],
              ),
              Text(
                viaText,
                style: TextStyles.text12Regular.copyWith(
                    color: AppColors.primary.withOpacityPrecise(0.6),
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsStack() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: SvgPicture.asset(Assets.images.svg.line1.path),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, top: 13),
          child: Column(
            children: [
              _buildDetailRow(
                iconPath: Assets.images.svg.calendar.path,
                text: dateRange,
                iconBgColor: AppColors.lightSkyBlue,
              ),
              const SizedBox(height: 4),
              _buildDetailRow(
                iconPath: Assets.images.svg.clock.path,
                text: timeRange,
                iconBgColor: AppColors.lightSkyBlue,
              ),
              const SizedBox(height: 4),
              _buildDetailRow(
                iconPath: Assets.images.svg.repeat.path,
                text: repeatText,
                iconBgColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required String iconPath,
    required String text,
    required Color iconBgColor,
  }) {
    return Row(
      children: [
        CustomCircleIcon(
          iconPath: iconPath,
          padding: const EdgeInsets.all(6),
          backgroundColor: iconBgColor,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyles.text12SemiBold
                .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.6)),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Text(
            distanceDuration,
            style: TextStyles.text16Regular.copyWith(color: AppColors.deepNavy),
          ),
        )),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: const BorderRadius.all(Radius.circular(21))),
            child: Text(
              "Route no. $routeNumber",
              style: TextStyles.text12SemiBold
                  .copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
    );
  }
}
