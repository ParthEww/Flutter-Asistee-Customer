import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/utils/common_utils.dart';
import 'package:project_structure/gen/assets.gen.dart';

import '../../core/widgets/custom/custom_circle_icon.dart';
import '../../core/widgets/custom/custom_header_with_tab.dart';
import '../bookingsummary/booking_summary_page.dart';
import '../dashboard/dashboard_controller.dart';
import 'live_tracking_controller.dart';

class LiveTrackingPage extends GetView<LiveTrackingController> {
  const LiveTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithTab(
                isBnvHeader: false, onTap: () {}),
            Expanded(
              child: Obx(() {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    if (CommonUtils.cameraPosition.value != null) ...[
                      GoogleMap(
                        initialCameraPosition:
                            CommonUtils.cameraPosition.value!,
                        onMapCreated: CommonUtils.mapController.call,
                      )
                    ],
                    Positioned.fill(
                        child: DraggableScrollableSheet(
                      initialChildSize: 0.84,
                      minChildSize: 0.84,
                      maxChildSize: 0.84,
                      expand: false,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              height: 300,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(44),
                                    topRight: Radius.circular(44)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32), // Slightly less than container radius
                                  topRight: Radius.circular(32),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Container(
                                          width: Get.width,
                                          padding: const EdgeInsets.symmetric(vertical: 13),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.all(Radius.circular(32))
                                          ),
                                          child: Center(child: Text("Onboard Bus", style: TextStyles.text14SemiBold.copyWith(color: AppColors.white),)),
                                        ),
                                        const SizedBox(height: 12),
                                        _buildBusDetailsCard(),
                                        const SizedBox(height: 12),
                                        Container(
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                              color: AppColors.lightMint,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      Assets.images.png
                                                          .dummyProfileImage.path,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Expanded(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      Text(
                                                        "Weekly, Repeat after 2 weeks",
                                                        style:
                                                            TextStyles.text14Medium,
                                                      ),
                                                      Text(
                                                        "On Monday, Wednesday, Thursday, Friday, Saturday, Sunday",
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyles
                                                            .text10Regular
                                                            .copyWith(
                                                                color: AppColors
                                                                    .deepNavy
                                                                    .withOpacityPrecise(
                                                                        0.6)),
                                                      )
                                                    ])),
                                                CustomCircleIcon(
                                                  iconPath: Assets
                                                      .images.svg.callBlack.path,
                                                  padding: const EdgeInsets.all(10),
                                                  backgroundColor:
                                                      AppColors.lightSkyBlue,
                                                ),
                                              ],
                                            )),
                                        const SizedBox(height: 12),
                                        _buildPriceDetailCard()
                                      ]),
                                ),
                              ),
                            ));
                      },
                    ))
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  /// Builds the bus details section with white card
  Widget _buildBusDetailsCard() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bus info section
            // _buildBusInfoSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleIcon(
                      iconPath: Assets.images.svg.calendar.path,
                      padding: const EdgeInsets.all(6),
                      backgroundColor: AppColors.lightMint,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "4th July 2024",
                        style: TextStyles.text12SemiBold.copyWith(
                            color: AppColors.deepNavy.withOpacityPrecise(0.6)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(21)),
                      ),
                      child: Text(
                        "BD 30/-",
                        style: TextStyles.text12SemiBold,
                      ),
                    )
                  ]),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SvgPicture.asset(
                  width: Get.width, Assets.images.svg.line4.path),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Manama",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.text18SemiBold
                              .copyWith(color: AppColors.deepNavy),
                        ),
                        Text(
                          "10:00 AM",
                          style: TextStyles.text12Regular
                              .copyWith(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(Assets.images.svg.line3.path),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: AppColors.lightBlue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(51)),
                                  border: Border.all(
                                      color: AppColors.white, width: 1)),
                              child: Text(
                                "2:30 Hrs",
                                style: TextStyles.text12SemiBold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        SvgPicture.asset(Assets.images.svg.bus16.path)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Budaiya",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.text18SemiBold
                              .copyWith(color: AppColors.deepNavy),
                        ),
                        Text(
                          "12:30 PM",
                          style: TextStyles.text12Regular
                              .copyWith(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacityPrecise(0.14),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "eCitaro eCitaro",
                        style: TextStyles.text18SemiBold
                            .copyWith(color: AppColors.deepNavy),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Blue, GLS BUS",
                        style: TextStyles.text12Medium,
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildBusNumberChip(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Helper widget for bus number chip
  Widget _buildBusNumberChip() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(left: 2, top: 2, right: 12, bottom: 2),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(66),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.white,
              child: SvgPicture.asset(Assets.images.svg.numberPlate.path),
            ),
            const SizedBox(width: 8),
            Text("GLS 001", style: TextStyles.text12SemiBold),
          ],
        ),
      ),
    );
  }

  /// Build price detail card
  Widget _buildPriceDetailCard() {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightMint,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CustomCircleIcon(
                  iconPath: Assets.images.svg.money.path,
                  padding: const EdgeInsets.all(8),
                  backgroundColor: AppColors.deepNavy,
                ),
                const SizedBox(width: 12),
                Text(
                  "Price Details",
                  style: TextStyles.text14SemiBold
                      .copyWith(color: AppColors.deepNavy),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceBreakDown(PriceBreakDownType.BUS_FARE, "30"),
                const SizedBox(height: 10),
                _buildPriceBreakDown(
                    PriceBreakDownType.PROMO_CODE_DISCOUNT, "5"),
                const SizedBox(height: 10),
                _buildPriceBreakDown(PriceBreakDownType.TAX_AND_CHARGES, "5"),
                const SizedBox(height: 20),
                SizedBox(
                    width: Get.width,
                    child: SvgPicture.asset(Assets.images.svg.line5.path,
                        fit: BoxFit.fill)),
                const SizedBox(height: 20),
                _buildPriceBreakDown(PriceBreakDownType.TOTAL_PAY, "30"),
              ],
            )
          ],
        ));
  }

  /// Builds price detail break down row
  Widget _buildPriceBreakDown(
      PriceBreakDownType priceBreakDownType, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          priceBreakDownType.label,
          style: TextStyles.text14Regular
              .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.4)),
        ),
        Text(
          "${priceBreakDownType == PriceBreakDownType.PROMO_CODE_DISCOUNT ? "-" : ""}BD $price",
          style: switch (priceBreakDownType) {
            PriceBreakDownType.PROMO_CODE_DISCOUNT => TextStyles.text14Regular
                .copyWith(
                    color: AppColors.deepNavy, fontStyle: FontStyle.italic),
            PriceBreakDownType.TOTAL_PAY => TextStyles.text14SemiBold,
            _ => TextStyles.text14Regular.copyWith(color: AppColors.deepNavy),
          },
        ),
      ],
    );
  }
}
