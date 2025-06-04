import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/themes/app_colors.dart';
import 'package:project_structure/gen/assets.gen.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initScreenDimensions(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              Assets.images.webp.splashScreenWeb.path, // Replace with your logo path
              width: double.infinity,
              fit: BoxFit.cover
            ),
          ),
          // Logo
          Center(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Assets.images.svg.appLogo.path,
                width: 186,
                height: 28,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
