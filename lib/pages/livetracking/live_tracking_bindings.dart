import 'package:get/get.dart';

import '../dashboard/dashboard_controller.dart';
import 'live_tracking_controller.dart';

class LiveTrackingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
