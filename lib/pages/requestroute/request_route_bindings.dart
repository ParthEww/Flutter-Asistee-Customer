import 'package:get/get.dart';

import 'request_route_controller.dart';

class RequestRouteBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RequestRouteController());
  }
}
