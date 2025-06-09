import 'package:get/get.dart';

import 'add_new_address_controller.dart';

class AddNewAddressBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AddNewAddressController());
  }
}
