import 'package:get/get.dart';

import '../dashboard/dashboard_controller.dart';
import 'pickup_drop_off_controller.dart';

class PickupDropOffBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
