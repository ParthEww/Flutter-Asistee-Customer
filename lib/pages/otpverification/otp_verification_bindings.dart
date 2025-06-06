import 'package:get/get.dart';

import 'otp_verification_controller.dart';

class OtpVerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpVerificationController());
  }
}
