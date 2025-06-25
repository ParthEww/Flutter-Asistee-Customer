import 'package:get/get.dart';

import 'request_route_controller.dart';

class RouteRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteRequestController());
  }
}
