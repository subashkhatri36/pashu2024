import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/bhush_repositories.dart';
import 'package:pasuhisab/app/data/model/bhush_model.dart';

class BhushController extends GetxController {
  BhushRepo bhushRepo = new BhushRepositories();
  RxInt totalAmount = 0.obs;
  bool updatebhus = false;
  Bhush currentBhush = Bhush(
      challid: 0, rate: 0, qty: 0, remarks: '', enterdate: DateTime.now());
  TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
//DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;
  RxBool isloading = false.obs;
  @override
  void onInit() {
    super.onInit();

    // loadChallRecord();
  }

  @override
  void onClose() {
    qtyController.dispose();
    rateController.dispose();
    remarkController.dispose();
  }

  calculateBhus() {
    if (qtyController.text.isNotEmpty && rateController.text.isNotEmpty) {
      totalAmount.value =
          int.parse(qtyController.text) * int.parse(rateController.text);
    } else {
      totalAmount.value = 0;
    }
  }

  loadBhush(int challid) async {
    isloading.toggle();
    var val = await bhushRepo.getAllBhush(challid);
    if (val != null) {
      currentBhush = new Bhush(
          challid: challid,
          rate: val?.rate ?? 0,
          qty: val?.qty ?? 0,
          remarks: val.remarks.isEmpty ? '' : val.remarks,
          enterdate: val.enterdate);
      currentBhush.total = val.qty * val.rate;
      totalAmount.value = val.qty * val.rate;
      currentBhush = val;
      selectForUpdate();
      updatebhus = true;
    } else
      currentBhush = Bhush(
          challid: 0, rate: 0, qty: 0, remarks: '', enterdate: DateTime.now());
    ;

    isloading.toggle();
  }

  savedBhush(int challid, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      Bhush b = new Bhush(
          challid: challid,
          rate: int.parse(rateController.text),
          qty: int.parse(qtyController.text),
          remarks: remarkController.text,
          enterdate: DateTime.now());

      int a = await bhushRepo.saveBhush(b);
      if (a > 0) {
        b.total = b.qty * b.rate;
        b.id = a;
        currentBhush = b;
        cleardata();
        Navigator.of(context).pop();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  selectForUpdate() {
    qtyController.text = currentBhush?.qty.toString() ?? 0.toString();
    rateController.text = currentBhush?.rate.toString() ?? 0.toString();
    remarkController.text = currentBhush?.remarks ?? '';
    //totalAmount.value = currentBhush?.qty ?? 0 * currentBhush?.rate ?? 0;
  }

  cleardata() {
    qtyController.text = rateController.text = remarkController.text = '';
  }

  updateBhush(int challid, BuildContext context) async {
    Bhush b = new Bhush(
        id: currentBhush.id,
        challid: challid,
        rate: int.parse(rateController.text),
        qty: int.parse(qtyController.text),
        remarks: remarkController.text,
        enterdate: DateTime.now());

    int update = await bhushRepo.updateBhush(b);
    if (update > 0) {
      b.total = b.qty * b.rate;
      currentBhush = b;
      Navigator.pop(context);
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  deleteBhush(int challid) async {
    int i = await bhushRepo.deleteBhush(challid);
    if (i > 0) {
      currentBhush = Bhush(
          challid: 0, rate: 0, qty: 0, remarks: '', enterdate: DateTime.now());
      ;
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }
}
