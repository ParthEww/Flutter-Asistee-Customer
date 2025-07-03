import 'package:get/get.dart';

import 'cms_controller.dart';

class CmsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CmsController());
  }
}
