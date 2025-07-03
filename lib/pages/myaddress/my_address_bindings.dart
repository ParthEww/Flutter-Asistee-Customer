import 'package:get/get.dart';

import '../dashboard/dashboard_controller.dart';
import 'my_address_controller.dart';

class MyAddressBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MyAddressController());
  }
}
