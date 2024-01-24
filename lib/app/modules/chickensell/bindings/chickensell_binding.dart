import 'package:get/get.dart';

import '../controllers/chickensell_controller.dart';

class ChickensellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChickensellController>(
      () => ChickensellController(),
    );
  }
}
