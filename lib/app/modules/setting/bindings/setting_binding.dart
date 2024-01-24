import 'package:get/get.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
      Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
