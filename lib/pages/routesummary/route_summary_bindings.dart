import 'package:get/get.dart';

import 'route_summary_controller.dart';

class RouteSummaryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteSummaryController());
  }
}
