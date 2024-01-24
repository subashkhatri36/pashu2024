import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get/get.dart';

class InternetConnectivityController extends GetxService {
  RxBool isInternetConnected = true.obs;
  @override
  void onInit() async {
    /// checks the connectivity status initially
    updateConnectionStatus(await Connectivity().checkConnectivity());
    super.onInit();
  }

  @override
  void onReady() {
    /// listens to the connectivity change and update the status
    Connectivity().onConnectivityChanged.listen((result) {
      updateConnectionStatus(result);
    });
    super.onReady();
  }

  @override
  void onClose() {}

  /// Updates the connection status and show dialog on no connection
  Future<void> updateConnectionStatus(result) async {
    Get.log("Connectivity Status => ${result.toString()}");
    // switch (result) {
    //   case ConnectivityResult.wifi:
    //   case ConnectivityResult.mobile:
    //     isInternetConnected.value = true;
    //     Get.back();
    //     break;
    //   case ConnectivityResult.none:
    //   default:
    //     isInternetConnected.value = false;
    //     NoInternetConnectionModal();
    //     break;
    // }
  }
}
