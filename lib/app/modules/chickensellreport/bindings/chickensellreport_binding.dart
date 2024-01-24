import 'package:get/get.dart';

import '../controllers/chickensellreport_controller.dart';

class ChickensellreportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChickensellreportController>(
      () => ChickensellreportController(),
    );
  }
}
