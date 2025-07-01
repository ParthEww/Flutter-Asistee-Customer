import 'package:get/get.dart';

import 'wallet_controller.dart';

class WalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletController());
  }
}
