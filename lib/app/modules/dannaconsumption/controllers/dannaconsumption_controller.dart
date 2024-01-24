import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/core/repositories/danaConsumption_repositories.dart';
import 'package:pasuhisab/app/data/model/dana_consumption.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class DannaconsumptionController extends GetxController {
  DanaConsumeRepo danaConsumeRepo = new DanaConsumeRepositories();
  RxList<DanaConsumption> danaConsumptionList =
      List<DanaConsumption>.empty(growable: true).obs;
  RxInt total = 0.obs;

  RxBool isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  loadingConsumption(int challid) async {
    isloading.toggle();
    final list = await danaConsumeRepo.getAlldanaConsumption(challid);
    if (list != null) {
      danaConsumptionList = list.obs;
      calculate();
    }

    isloading.toggle();
  }

  deleteConsumption(int id, DanaConsumption dc, BuildContext context) async {
    bool result = await dialogBox(context,
        title: 'Warning !',
        message: 'Are you sure to delete this Dana Consumption ?',
        btnname: 'Delete');
    if (result) {
      int res = await danaConsumeRepo.deleteConsumption(id);
      if (res > 0) {
        danaConsumptionList.remove(dc);
        calculate();
      }
    }
  }

  calculate() {
    total.value = 0;
    for (var element in danaConsumptionList) {
      total.value += element.qty;
    }
  }

  String danaSwitch(int danaid) {
    switch (danaid) {
      case 1:
        return 'B0';
        break;
      case 2:
        return 'B1';
        break;
      case 3:
        return 'B2';
        break;
      case 4:
        return 'L3';
        break;
      default:
        return 'No';
        break;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
