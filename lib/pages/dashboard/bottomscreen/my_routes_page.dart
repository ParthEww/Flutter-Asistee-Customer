import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/core/utils/common_utils.dart';

import '../../../api/model/static/route_request_type.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';
import '../../../core/widgets/custom/custom_header_with_tab.dart';
import '../../../core/widgets/custom/custom_route_card.dart';
import '../dashboard_controller.dart';

class MyRoutesPage extends GetView<DashboardController> {
  const MyRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CommonUtils.activeTabBarBookingStatus.value = BookingStatusType.REQUEST_ROUTE;
    CommonUtils.commonTabList = [
      BookingStatusType.REQUEST_ROUTE
    ];
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithTab(
                controller: controller, isBnvHeader: true, onTap: () {
              CommonDropdownSelectionBottomSheet.showBottomSheet(
                commonList: routeRequestTypeList,
                dialogType: CommonDropdownSelectionBottomSheetDialogType.SELECT_ROUTE_BOOKING_TYPE,
                onTap: (dialogType, selectedItemIndex){
                  controller.onGoToRouteRequest();
                }
              );
            }),
            Expanded(
                child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
              child: Obx(() => CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: GestureDetector(
                                  onTap: () {},
                                  child: CustomRouteCard(
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
                      ])),
            ))
          ],
        ),
      ),
    );
  }
}
