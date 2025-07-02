import 'package:get/get.dart';

import 'faqs_controller.dart';

class FaqsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FaqsController());
  }
}
