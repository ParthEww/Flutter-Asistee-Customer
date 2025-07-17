
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../splash/notifier/splash_notifier.dart';

class SplashPage extends ConsumerWidget {

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashNotifierProvider);
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