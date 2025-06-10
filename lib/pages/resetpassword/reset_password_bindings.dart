import 'package:get/get.dart';

import 'reset_password_controller.dart';

class ResetPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}
