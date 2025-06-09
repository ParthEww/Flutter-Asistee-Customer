part of 'app_pages.dart';

abstract class Routes {
  static const String splash = _Path.splash;
  static const String onboarding = _Path.onboarding;
  static const String login = _Path.login;
  static const String register = _Path.register;
  static const String forgotPassword = _Path.forgotPassword;
  static const String otpVerification = _Path.otpVerification;
  static const String addNewAddress = _Path.addNewAddress;
}

abstract class _Path {
  static const String splash = "/splash";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgotPassword";
  static const String otpVerification = "/otpVerification";
  static const String addNewAddress = "/addNewAddress";
}
