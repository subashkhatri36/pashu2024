import 'package:get/get.dart';

import '../controllers/dana_controller.dart';

class DanaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DanaController>(
      () => DanaController(),
    );
    
  }
}
