import 'package:get/get.dart';

import 'define_booking_rule_controller.dart';

class DefineBookingRuleBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DefineBookingRuleController());
  }
}
