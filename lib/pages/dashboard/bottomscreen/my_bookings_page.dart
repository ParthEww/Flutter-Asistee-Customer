import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/gen/assets.gen.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/custom/custom_header_with_tab.dart';
import '../../../core/widgets/custom/custom_header_with_tab.dart';
import '../../../core/widgets/custom/custom_ongoing_route_card.dart';
import '../../../core/widgets/custom/custom_route_card.dart';
import '../dashboard_controller.dart';

class MyBookingsPage extends GetView<DashboardController> {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.activeTabBarBookingStatus.value = BookingStatusType.ONGOING;
    controller.commonTabList = [
      BookingStatusType.ONGOING,
      BookingStatusType.UPCOMING,
      BookingStatusType.PAST
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithTab(controller: controller, isBnvHeader: true),
            Expanded(
                child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
              child: Obx(() {
                print(controller.activeTabBarBookingStatus.value.title);
                return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: GestureDetector(
                                onTap: () {},
                                child: controller
                                            .activeTabBarBookingStatus.value ==
                                        BookingStatusType.ONGOING
                                    ? CustomOngoingRouteCard(
                                        startLocation:
                                            "Manama Manama Manama Manama",
                                        endLocation:
                                            "Budaiya Budaiya Budaiya Budaiya",
                                        viaText: "Via Jidhafs & Budaiya Hwy",
                                        dateRange: "4th July 2024",
                                        startTime: "10:00 AM",
                                        endTime: "12:30 PM",
                                        repeatText:
                                            "Weekly Recuring, Repeat after 2 weeks Weekly Recuring, Repeat after 2 weeks",
                                        distanceDuration: "2:30",
                                        routeNumber: "12356",
                                        isOnboard: controller
                                                .routeDataList[index]
                                                .isOnboard ??
                                            false,
                                        onTap: (){
                                          controller.onGoToLiveTracking();
                                        },
                                      )
                                    : CustomRouteCard(
                                        startLocation:
                                            "Manama Manama Manama Manama",
                                        endLocation:
                                            "Budaiya Budaiya Budaiya Budaiya",
                                        viaText: "Via Jidhafs & Budaiya Hwy",
                                        dateRange:
                                            "From: 1st Oct 2024 - To: 27th Oct 2024 From: 1st Oct 2024 - To: 27th Oct 2024",
                                        timeRange:
                                            "10:00 AM to 12:30 PM 10:00 AM to 12:30 PM",
                                        repeatText:
                                            "Weekly Recuring, Repeat after 2 weeks Weekly Recuring, Repeat after 2 weeks",
                                        distanceDuration: "60Km - 2:30 Hrs",
                                        routeNumber: "Route no. 12356",
                                        requestType: controller
                                            .routeDataList[index].requestType
                                            .orEmpty(),
                                        bottomNavigationScreenType: controller
                                            .activeBottomNavigationScreenType
                                            .value,
                                        onTap: () {
                                          controller.onGoToTripDetail();
                                        }),
                              )),
                          childCount: controller.routeDataList.length,
                        ),
                      )
                    ]);
              }),
            ))
          ],
        ),
      ),
    );
  }
}
