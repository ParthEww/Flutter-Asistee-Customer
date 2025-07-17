part of 'app_pages.dart';

abstract class AppRoutes {
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
  static const String pickupDropOff = _Path.pickupDropOff;
  static const String bookingSummary = _Path.bookingSummary;
  static const String promoCodes = _Path.promoCodes;
  static const String routeSummary = _Path.routeSummary;
  static const String requestRoute = _Path.requestRoute;
  static const String defineBookingRule = _Path.defineBookingRule;
  static const String liveTracking = _Path.liveTracking;
  static const String wallet = _Path.wallet;
  static const String contactUs = _Path.contactUs;
  static const String faqs = _Path.faqs;
  static const String notifications = _Path.notifications;
  static const String myAddress = _Path.myAddress;
  static const String cms = _Path.cms;
}

abstract class _Path {
  static const String splash = "/splash";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgotpassword";
  static const String otpVerification = "/otpverification";
  static const String resetPassword = "/resetpassword";
  static const String addNewAddress = "/addNewAddress";
  static const String dashboard = "/dashboard";
  static const String editProfile = "/editprofile";
  static const String tripDetail = "/tripdetail";
  static const String pickupDropOff = "/pickupdropoff";
  static const String bookingSummary = "/bookingsummary";
  static const String promoCodes = "/promocodes";
  static const String routeSummary = "/routesummary";
  static const String requestRoute = "/requestroute";
  static const String defineBookingRule = "/definebookingrule";
  static const String liveTracking = "/livetracking";
  static const String wallet = "/wallet";
  static const String contactUs = "/contactus";
  static const String faqs = "/faqs";
  static const String notifications = "/notifications";
  static const String myAddress = "/myaddress";
  static const String cms = "/cms";
}
