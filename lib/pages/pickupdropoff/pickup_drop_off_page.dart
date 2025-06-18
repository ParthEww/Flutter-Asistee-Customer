import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/core/themes/text_styles.dart';
import 'package:project_structure/core/utils/app_extension.dart';
import 'package:project_structure/core/widgets/app_button.dart';
import 'package:project_structure/core/widgets/app_text_field.dart';
import 'package:project_structure/core/widgets/app_text_field_label.dart';
import 'package:project_structure/core/widgets/app_text_field_required_label.dart';
import 'package:project_structure/core/widgets/custom/custom_header.dart';
import 'package:project_structure/core/widgets/custom/custom_header_with_tab.dart';
import 'package:project_structure/core/widgets/custom/custom_tag_button.dart';
import 'package:project_structure/core/widgets/custom/custom_text_filed.dart';
import 'package:project_structure/gen/assets.gen.dart';
import 'package:project_structure/gen/fonts.gen.dart';
import 'package:project_structure/pages/dashboard/dashboard_controller.dart';
import 'package:retrofit/http.dart';

import '../../api/model/static/address_type.dart';
import '../../core/widgets/custom/custom_auth_header_with_back_button.dart';
import '../../core/widgets/custom/custom_back_button.dart';
import '../../core/widgets/custom/custom_circle_icon.dart';
import 'pickup_drop_off_controller.dart';

class PickupDropOffPage extends GetView<DashboardController> {
  const PickupDropOffPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.activeTabBarBookingStatus.value = BookingStatusType.PICK_UP;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: CustomHeaderWithTab(
            controller: controller,
            isBnvHeader: false,
          )
      ),
    );
  }
}
