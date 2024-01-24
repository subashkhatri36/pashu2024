import 'package:get/get.dart';

import '../controllers/dannaconsumption_controller.dart';

class DannaconsumptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DannaconsumptionController>(
      () => DannaconsumptionController(),
    );
  }
}
