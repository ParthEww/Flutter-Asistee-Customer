import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/themes/app_colors.dart';
import '../dashboard_controller.dart';

class MyBookingsPage extends GetView<DashboardController> {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Container(

        ),
      ),
    );
  }
}