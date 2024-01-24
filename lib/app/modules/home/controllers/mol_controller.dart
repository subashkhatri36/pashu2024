import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/mol_repositories.dart';
import 'package:pasuhisab/app/data/model/mol_model.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class MolController extends GetxController {
  MolRepo molRepo = new MolRepositories();
  RxInt totalAmount = 0.obs;
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController boraController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  RxString todayDate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;

  RxList<MolModel> mollist = List<MolModel>.empty(growable: true).obs;
  RxBool isloading = false.obs;
  getAllMol(int challid) async {
    isloading.toggle();
    List<MolModel> mlist = await molRepo.getAllMolModel(challid);
    if (mollist != null && mollist!.isNotEmpty) mollist = mlist.obs;
    isloading.toggle();
  }

  deletemol(MolModel mole, BuildContext context) async {
    bool result = await dialogBox(context,
        title: 'Warning !',
        message: 'Are you sure to delete this this Mol ?',
        btnname: 'Delete');
    if (result) {
      int i = await molRepo.deleteMolModel(mole.id);
      if (i > 0) {
        mollist.remove(mole);
        Get.snackbar(info.tr, deleteMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  calculated() {
    if (boraController.text.isNotEmpty && amountController.text.isNotEmpty) {
      totalAmount.value =
          int.parse(boraController.text) * int.parse(amountController.text);
    } else {
      totalAmount.value = 0;
    }
  }

  int id = 0;
  selectForUpdate(MolModel model) {
    id = model.id;
    boraController.text = model.qty.toString();
    amountController.text = model.rate.toString();
  }

  saveMol(int challid) async {
    if (formkey.currentState?.validate() ?? false) {
      MolModel m = new MolModel(
          qty: int.parse(boraController.text),
          rate: int.parse(amountController.text),
          challid: challid,
          enterdate: DateTime.now());

      int res = await molRepo.saveMolModel(m);
      if (res > 0) {
        clearData();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  updateMol(int challid, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      MolModel m = new MolModel(
          id: id,
          qty: int.parse(boraController.text),
          rate: int.parse(amountController.text),
          challid: challid,
          enterdate: DateTime.now());

      int res = await molRepo.updateMolModel(m);
      if (res > 0) {
        Navigator.of(context).pop();
        clearData();
        Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  clearData() {
    boraController.text = '';
    amountController.text = '';
    totalAmount.value = 0;
  }

  @override
  void onClose() {
    boraController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
