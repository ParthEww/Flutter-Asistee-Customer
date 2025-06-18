import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/pages/dashboard/dashboard_controller.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/text_styles.dart';
import 'custom_circle_icon.dart';

class CustomRouteCard extends StatelessWidget {
  // Card properties
  final String startLocation;
  final String endLocation;
  final String viaText;
  final String dateRange;
  final String timeRange;
  final String repeatText;
  final String distanceDuration;
  final String routeNumber;
  final String requestType;
  final BottomNavigationScreenType bottomNavigationScreenType;
  final VoidCallback onTap;

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
    required this.requestType,
    required this.bottomNavigationScreenType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.lightMint,
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main content padding
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with start and end locations
                  _buildLocationRow(),
                  const SizedBox(height: 7),
                  // Timeline with route details
                  _buildDetailsStack(),
                ],
              ),
            ),
            // Footer section with distance and route number
            _buildFooterRow(),
          ],
        ),
      ),
    );
  }

  /// Builds the row containing start and end locations with route icon
  Widget _buildLocationRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Route icon
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
              // Start and end location with arrow
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
              // Via text (intermediate stops)
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

  /// Builds the vertical timeline with route details (date, time, repeat)
  Widget _buildDetailsStack() {
    return Stack(
      children: [
        // Vertical line decoration
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: SvgPicture.asset(Assets.images.svg.line1.path,
              height: requestType == RouteRequestType.RECURRING.id ? 90 : 75),
        ),
        // Route details items
        Padding(
          padding: const EdgeInsets.only(left: 13, top: 13),
          child: Column(
            children: [
              // Date range
              _buildDetailRow(
                iconPath: Assets.images.svg.calendar.path,
                text: dateRange,
                iconBgColor: AppColors.lightSkyBlue,
              ),
              const SizedBox(height: 4),
              // Time range
              _buildDetailRow(
                iconPath: Assets.images.svg.clock.path,
                text: timeRange,
                iconBgColor: AppColors.lightSkyBlue,
              ),
              // Repeat information (only for recurring routes)
              if (requestType == RouteRequestType.RECURRING.id) ...[
                const SizedBox(height: 4),
                _buildDetailRow(
                  iconPath: Assets.images.svg.repeat.path,
                  text: repeatText,
                  iconBgColor: AppColors.primary,
                )
              ]
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a single detail row with icon and text
  Widget _buildDetailRow({
    required String iconPath,
    required String text,
    required Color iconBgColor,
  }) {
    return Row(
      children: [
        // Circular icon
        CustomCircleIcon(
          iconPath: iconPath,
          padding: const EdgeInsets.all(6),
          backgroundColor: iconBgColor,
        ),
        const SizedBox(width: 10),
        // Detail text
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

  /// Builds the footer section with different layouts based on screen type
  Widget _buildFooterRow() {
    return bottomNavigationScreenType == BottomNavigationScreenType.MY_ROUTES
        ?
        // My Routes screen version (single centered text)
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: const BorderRadius.all(Radius.circular(51)),
            ),
            child: Text(
              "Pending Approval",
              style:
                  TextStyles.text16Regular.copyWith(color: AppColors.deepNavy),
            ),
          )
        :
        // Other screens version (split between distance and route number)
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Distance and duration
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
                  style: TextStyles.text16Regular
                      .copyWith(color: AppColors.deepNavy),
                ),
              )),
              const SizedBox(width: 8),
              // Route number
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(21))),
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
