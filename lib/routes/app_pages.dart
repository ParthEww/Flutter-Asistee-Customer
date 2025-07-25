import 'package:get/get.dart';
import 'package:project_structure/pages/addnewaddress/add_new_address_bindings.dart';
import 'package:project_structure/pages/dashboard/dashboard_bindings.dart';
import 'package:project_structure/pages/editprofile/edit_profile_bindings.dart';
import 'package:project_structure/pages/livetracking/live_tracking_bindings.dart';
import 'package:project_structure/pages/login/login_bindings.dart';
import 'package:project_structure/pages/login/login_page.dart';
import 'package:project_structure/pages/otpverification/otp_verification_bindings.dart';
import 'package:project_structure/pages/pickupdropoff/pickup_drop_off_bindings.dart';
import 'package:project_structure/pages/routesummary/route_summary_bindings.dart';

import '../pages/addnewaddress/add_new_address_page.dart';
import '../pages/bookingsummary/booking_summary_bindings.dart';
import '../pages/bookingsummary/booking_summary_page.dart';
import '../pages/cms/cms_bindings.dart';
import '../pages/cms/cms_page.dart';
import '../pages/contactus/contact_us_bindings.dart';
import '../pages/contactus/contact_us_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/definebookingrule/define_booking_rule_bindings.dart';
import '../pages/definebookingrule/define_booking_rule_page.dart';
import '../pages/editprofile/edit_profile_page.dart';
import '../pages/faqs/faqs_bindings.dart';
import '../pages/faqs/faqs_page.dart';
import '../pages/forgotpassword/forgot_password_bindings.dart';
import '../pages/forgotpassword/forgot_password_page.dart';
import '../pages/livetracking/live_tracking_page.dart';
import '../pages/myaddress/my_address_bindings.dart';
import '../pages/myaddress/my_address_page.dart';
import '../pages/notifications/notifications_bindings.dart';
import '../pages/notifications/notifications_page.dart';
import '../pages/onboarding/onboarding_bindings.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/otpverification/otp_verification_page.dart';
import '../pages/pickupdropoff/pickup_drop_off_page.dart';
import '../pages/promocodes/promo_codes_bindings.dart';
import '../pages/promocodes/promo_codes_page.dart';
import '../pages/register/register_bindings.dart';
import '../pages/register/register_page.dart';
import '../pages/requestroute/request_route_bindings.dart';
import '../pages/requestroute/request_route_page.dart';
import '../pages/resetpassword/reset_password_bindings.dart';
import '../pages/resetpassword/reset_password_page.dart';
import '../pages/routesummary/route_summary_page.dart';
import '../pages/splash/splash_bindings.dart';
import '../pages/splash/splash_page.dart';
import '../pages/tripdetail/trip_detail_bindings.dart';
import '../pages/tripdetail/trip_detail_page.dart';
import '../pages/wallet/wallet_bindings.dart';
import '../pages/wallet/wallet_page.dart';

part 'app_routes.dart';

class AppPages {
  // initial route
  static String initialRoute = _Path.addNewAddress;
  static Bindings initialBinding = AddNewAddressBindings();

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

    /// otp verification page
    GetPage(
      name: _Path.otpVerification,
      page: () => const OtpVerificationPage(),
      binding: OtpVerificationBindings(),
    ),

    /// reset password page
    GetPage(
      name: _Path.resetPassword,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBindings(),
    ),

    /// add new address page
    GetPage(
      name: _Path.addNewAddress,
      page: () => const AddNewAddressPage(),
      binding: AddNewAddressBindings(),
    ),

    /// dashboard page
    GetPage(
      name: _Path.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBindings(),
    ),

    /// edit profile page
    GetPage(
      name: _Path.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBindings(),
    ),

    /// trip detail page
    GetPage(
      name: _Path.tripDetail,
      page: () => const TripDetailPage(),
      binding: TripDetailBindings(),
    ),

    /// pickup drop-off page
    GetPage(
      name: _Path.pickupDropOff,
      page: () => const PickupDropOffPage(),
      binding: PickupDropOffBindings(),
    ),

    /// booking summary page
    GetPage(
      name: _Path.bookingSummary,
      page: () => const BookingSummaryPage(),
      binding: BookingSummaryBindings(),
    ),

    /// promo codes page
    GetPage(
      name: _Path.promoCodes,
      page: () => const PromoCodesPage(),
      binding: PromoCodesBindings(),
    ),

    /// route summary page
    GetPage(
      name: _Path.routeSummary,
      page: () => const RouteSummaryPage(),
      binding: RouteSummaryBindings(),
    ),

    /// route request page
    GetPage(
      name: _Path.requestRoute,
      page: () => const RequestRoutePage(),
      binding: RequestRouteBindings(),
    ),

    /// define booking rule page
    GetPage(
      name: _Path.defineBookingRule,
      page: () => const DefineBookingRulePage(),
      binding: DefineBookingRuleBindings(),
    ),

    /// live tracking page
    GetPage(
      name: _Path.liveTracking,
      page: () => const LiveTrackingPage(),
      binding: LiveTrackingBindings(),
    ),

    /// wallet page
    GetPage(
      name: _Path.wallet,
      page: () => const WalletPage(),
      binding: WalletBindings(),
    ),

    /// contact us page
    GetPage(
      name: _Path.contactUs,
      page: () => const ContactUsPage(),
      binding: ContactUsBindings(),
    ),

    /// faqs page
    GetPage(
      name: _Path.faqs,
      page: () => const FaqsPage(),
      binding: FaqsBindings(),
    ),

    /// notifications page
    GetPage(
      name: _Path.notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBindings(),
    ),

    /// my address page
    GetPage(
      name: _Path.myAddress,
      page: () => const MyAddressPage(),
      binding: MyAddressBindings(),
    ),

    /// cms page
    GetPage(
      name: _Path.cms,
      page: () => const CmsPage(),
      binding: CmsBindings(),
    ),
  ];
}
