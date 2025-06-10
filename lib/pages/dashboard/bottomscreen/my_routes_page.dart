import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/themes/app_colors.dart';
import '../dashboard_controller.dart';

class MyRoutesPage extends GetView<DashboardController> {
  const MyRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: SafeArea(
        child: Container(

        ),
      ),
    );
  }
}