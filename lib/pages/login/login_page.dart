import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(),
            )
          ],
        ),
      ),
    );
  }
}
