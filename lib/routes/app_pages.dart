import 'package:get/get.dart';
import 'package:project_structure/pages/login/login_bindings.dart';
import 'package:project_structure/pages/login/login_page.dart';

import '../pages/forgotpassword/forgot_password_bindings.dart';
import '../pages/forgotpassword/forgot_password_page.dart';
import '../pages/onboarding/onboarding_bindings.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/register/register_bindings.dart';
import '../pages/register/register_page.dart';
import '../pages/splash/splash_bindings.dart';
import '../pages/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  // initial route
  static String initialRoute = _Path.splash;
  static Bindings initialBinding = SplashBindings();

  static final List<GetPage<dynamic>> pages = [
    /// splash page
    GetPage(
      name: _Path.splash,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),

    /// onboarding page
    GetPage(
      name: _Path.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBindings(),
    ),

    /// login page
    GetPage(
      name: _Path.login,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),

    /// register page
    GetPage(
      name: _Path.register,
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
    ),

    /// forgot password page
    GetPage(
      name: _Path.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBindings(),
    ),
  ];
}
