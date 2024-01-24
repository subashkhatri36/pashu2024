import 'package:get/get.dart';
import 'package:pasuhisab/app/modules/home/controllers/add_chicks_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/bhush_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/egg_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/electricity_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/labour_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/medicine_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/mol_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/other_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ChicksRecordController>(
      () => ChicksRecordController(),
    );
    Get.lazyPut<BhushController>(
      () => BhushController(),
    );
    Get.lazyPut<MedicineController>(
      () => MedicineController(),
    );
    Get.lazyPut<ElectricityController>(
      () => ElectricityController(),
    );

    Get.lazyPut<EggController>(
      () => EggController(),
    );
    Get.lazyPut<MolController>(
      () => MolController(),
    );

    Get.lazyPut<LaborController>(
      () => LaborController(),
    );
  

    Get.lazyPut<OtherController>(
      () => OtherController(),
    );

    Get.lazyPut<ElectricityController>(
      () => ElectricityController(),
    );
    Get.lazyPut<ElectricityController>(
      () => ElectricityController(),
    );
  }
}
