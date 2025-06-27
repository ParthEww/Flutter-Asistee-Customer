import 'package:get/get.dart';

import '../routesummary/route_summary_controller.dart';

class DefineBookingRuleBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteSummaryController());
  }
}
