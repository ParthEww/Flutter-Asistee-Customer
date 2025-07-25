import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/pages/preference/preference_page.dart';

import '../pages/auth/login/login_page.dart';
import '../pages/auth/otpverification/otp_verification_page.dart';
import '../pages/auth/register/register_page.dart';
import '../pages/auth/resetpassword/reset_password_page.dart';
import '../pages/chat/chat_page.dart';
import '../pages/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerificationPage());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordPage());
      case AppRoutes.chat:
        return MaterialPageRoute(builder: (_) => const ChatPage());
      case AppRoutes.preference:
        return MaterialPageRoute(builder: (_) => const PreferencePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
