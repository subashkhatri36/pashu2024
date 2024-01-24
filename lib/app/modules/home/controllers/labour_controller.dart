import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/labor_repositiories.dart';
import 'package:pasuhisab/app/data/model/labor.dart';

class LaborController extends GetxController {
  LaborRepo laborRepo = new LaborRepositories();
  // RxInt totalAmount = 0.obs;
  bool updatelabor = false;
  Labor? labor;
  RxBool isloading = false.obs;

  // TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  String todaydate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString();

  @override
  void onInit() {
    super.onInit();

    // loadChallRecord();
  }

  @override
  void onClose() {
    // qtyController.dispose();
    rateController.dispose();
    remarkController.dispose();
  }

  loadLabor(int challid) async {
    isloading.toggle();
    var val = await laborRepo.getAllLabor(challid);
    if (val != null) {
      labor = val;
      selectForUpdate();
      updatelabor = true;
    } else
      labor = null;
    isloading.toggle();
  }

  savedLabor(int challid, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      Labor b = new Labor(
          challid: challid,
          remarks: remarkController.text,
          total: int.parse(rateController.text),
          enterdate: DateTime.now());

      int a = await laborRepo.saveLabor(b);
      if (a > 0) {
        b.id = a;
        labor = b;
        Navigator.of(context).pop();
        cleardata();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  cleardata() {
    rateController.clear();
    remarkController.clear();
  }

  selectForUpdate() {
    // qtyController.text = egg.qty.toString();
    rateController.text = labor?.total.toString() ?? '0';
    remarkController.text = labor?.remarks ?? '';
    //  totalAmount.value = egg.total;
  }

  updateLabor(
    int challid,
    BuildContext context,
  ) async {
    Labor b = new Labor(
      id: labor?.id ?? 0,
      challid: challid,
      remarks: remarkController.text,
      total: int.parse(rateController.text),
      enterdate: labor?.enterdate ?? DateTime.now(),
    );

    int update = await laborRepo.updateLabor(b);
    if (update > 0) {
      labor = b;

      Navigator.of(context).pop();
      cleardata();
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  deleteLabor(int challid) async {
    int i = await laborRepo.deleteLabor(challid);
    if (i > 0) {
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }
}
