import 'package:get/get.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
//import 'package:pasuhisab/app/core/controller/sqlite_helper.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(),
    );

    // Get.put(InternetConnectivityController(), permanent: true);
  }
}
