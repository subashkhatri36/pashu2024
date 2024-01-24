import 'package:get/get.dart';

import '../controllers/addselling_controller.dart';

class AddsellingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddsellingController>(
      () => AddsellingController(),
    );
  }
}
