part of 'app_pages.dart';

abstract class Routes {
  static const String splash = _Path.splash;
  static const String onboarding = _Path.onboarding;
  static const String login = _Path.login;
  static const String register = _Path.register;
  static const String forgotPassword = _Path.forgotPassword;
  static const String otpVerification = _Path.otpVerification;
  static const String resetPassword = _Path.resetPassword;
  static const String addNewAddress = _Path.addNewAddress;
  static const String dashboard = _Path.dashboard;
  static const String editProfile = _Path.editProfile;
  static const String tripDetail = _Path.tripDetail;
}

abstract class _Path {
  static const String splash = "/splash";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgotPassword";
  static const String otpVerification = "/otpVerification";
  static const String resetPassword = "/resetPassword";
  static const String addNewAddress = "/addNewAddress";
  static const String dashboard = "/dashboard";
  static const String editProfile = "/editProfile";
  static const String tripDetail = "/tripDetail";
}
