import 'package:get/get.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}
