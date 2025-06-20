import 'package:get/get.dart';

import 'promo_codes_controller.dart';

class PromoCodesBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PromoCodesController());
  }
}
