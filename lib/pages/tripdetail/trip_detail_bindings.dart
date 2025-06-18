import 'package:get/get.dart';

import 'trip_detail_controller.dart';

class TripDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TripDetailController());
  }
}
