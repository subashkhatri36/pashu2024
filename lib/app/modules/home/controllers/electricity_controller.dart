import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/electricity_repositories.dart';
import 'package:pasuhisab/app/data/model/ele_model.dart';

class ElectricityController extends GetxController {
  ElectricityRepo electricityRepo = new ElectricityRepositories();
  RxInt totalAmount = 0.obs;
  bool updateElect = false;
  EleModel currentEleModel = EleModel(
    rent: 0,
    electricity: 0,
    water: 0,
    challid: 0,
    enterdate: DateTime.now(),
  );
  TextEditingController electricityController = new TextEditingController();
  TextEditingController rentController = new TextEditingController();
  TextEditingController waterController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
//DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;

  @override
  void onInit() {
    super.onInit();

    // loadChallRecord();
  }

  @override
  void onClose() {
    electricityController.dispose();
    rentController.dispose();
    waterController.dispose();
  }

  RxBool isloading = false.obs;

  loadEleModel(int challid) async {
    isloading.toggle();
    var val = await electricityRepo.getAllEleModel(challid);
    if (val != null) {
      totalAmount.value =
          val?.electricity ?? 0 + (val?.rent ?? 0) + (val?.water ?? 0);
      currentEleModel = val;
      selectForUpdate();
      updateElect = true;
    }

    isloading.toggle();
  }

  savedEleModel(int challid, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      EleModel b = new EleModel(
          rent: int.parse(
              rentController.text.isNotEmpty ? rentController.text : '0'),
          electricity: int.parse(electricityController.text.isNotEmpty
              ? electricityController.text
              : '0'),
          water: int.parse(
              waterController.text.isNotEmpty ? waterController.text : '0'),
          challid: challid,
          enterdate: DateTime.now());

      int a = await electricityRepo.saveEleModel(b);
      if (a > 0) {
        b.total = totalAmount.value;
        b.id = a;
        currentEleModel = b;
        Navigator.of(context).pop();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  calculatetotal() {
    totalAmount.value = 0;
    if (electricityController.text.isNotEmpty) {
      totalAmount.value += int.parse(electricityController.text);
    }
    if (waterController.text.isNotEmpty)
      totalAmount.value += int.parse(waterController.text);
    if (rentController.text.isNotEmpty)
      totalAmount.value += int.parse(rentController.text);
  }

  selectForUpdate() {
    electricityController.text = currentEleModel.electricity.toString();
    waterController.text = currentEleModel.water.toString();
    rentController.text = currentEleModel.rent.toString();
    totalAmount.value = currentEleModel.electricity +
        currentEleModel.rent +
        currentEleModel.water;
  }

  updateEleModel(int challid, BuildContext context) async {
    EleModel b = new EleModel(
        id: currentEleModel.id,
        rent: int.parse(
            rentController.text.isNotEmpty ? rentController.text : '0'),
        electricity: int.parse(electricityController.text.isNotEmpty
            ? electricityController.text
            : '0'),
        water: int.parse(
            waterController.text.isNotEmpty ? waterController.text : '0'),
        challid: challid,
        enterdate: DateTime.now());

    int update = await electricityRepo.updateEleModel(b);
    if (update > 0) {
      b.total = b.electricity + b.rent + b.water;
      currentEleModel = b;
      Navigator.of(context).pop();
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  deleteEleModel(int challid) async {
    int i = await electricityRepo.deleteEleModel(challid);
    if (i > 0) {
      currentEleModel = EleModel(
        rent: 0,
        electricity: 0,
        water: 0,
        challid: 0,
        enterdate: DateTime.now(),
      );
      ;
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }
}
