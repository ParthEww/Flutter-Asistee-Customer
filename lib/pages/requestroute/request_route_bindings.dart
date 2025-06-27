import 'package:get/get.dart';

import '../routesummary/route_summary_controller.dart';

class RequestRouteBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteSummaryController());
  }
}
