import 'package:get/get.dart';

import 'booking_summary_controller.dart';

class BookingSummaryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingSummaryController());
  }
}
