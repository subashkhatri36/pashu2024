import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/egg_repositories.dart';
import 'package:pasuhisab/app/data/model/egg_model.dart';

class EggController extends GetxController {
  EggRepo eggRepo = new EggRepositories();
  RxInt totalAmount = 0.obs;
  bool updateegg = false;

  TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  // TextEditingController remarkController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  String todaydate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString();
  RxList<EggModel> eggmodellist = List<EggModel>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();

    // loadChallRecord();
  }

  calculated() {
    if (qtyController.text.isNotEmpty && rateController.text.isNotEmpty) {
      totalAmount.value =
          int.parse(qtyController.text) * int.parse(rateController.text);
    } else {
      totalAmount.value = 0;
    }
  }

  @override
  void onClose() {
    qtyController.dispose();
    rateController.dispose();
    //  remarkController.dispose();
  }

  cleardata() {
    qtyController.text = '';
    rateController.text = '';
    totalAmount.value = 0;
  }

  RxBool isloading = false.obs;
  loadEgg(int challid) async {
    isloading.toggle();
    var val = await eggRepo.getAllEggModel(challid);
    if (val != null) eggmodellist = val.obs;

    isloading.toggle();
  }

  savedEgg(int challid, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      EggModel b = new EggModel(
          qty: int.parse(qtyController.text),
          rate: int.parse(rateController.text),
          challid: challid,
          enterdate: DateTime.now());

      int a = await eggRepo.saveEggModel(b);
      if (a > 0) {
        cleardata();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  selectForUpdate(EggModel egg) {
    qtyController.text = egg.qty.toString();
    rateController.text = egg.rate.toString();
    // remarkController.text = currentEgg.remarks;
    totalAmount.value = egg.total;
  }

  updateEgg(int challid, EggModel model, BuildContext context) async {
    EggModel b = new EggModel(
        id: model.id,
        qty: int.parse(qtyController.text),
        rate: int.parse(rateController.text),
        challid: challid,
        enterdate: DateTime.now());

    int update = await eggRepo.updateEggModel(b);
    if (update > 0) {
      Navigator.of(context).pop();
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  deleteEgg(int id) async {
    int i = await eggRepo.deleteEggModel(id);
    if (i > 0) {
      Get.snackbar(info.tr, deleteMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }
}
