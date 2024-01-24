import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/selling_repositiories.dart';
import 'package:pasuhisab/app/data/model/chall_selling_record.dart';
import 'package:pasuhisab/app/data/model/sel_model.dart';

class AddsellingController extends GetxController {
  SellingRepo sellingRepo = new SellingRepositories();

  RxString todayDate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;
  RxInt totalAmount = 0.obs;
  String today = '';
  bool updateded = false;
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController billnoController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController travelController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  calculatetotal({Sel? sell, Selling? selling}) {
    double dtotal = 0;
    if (rateController.text.isNotEmpty) {
      if (sell != null) {
        dtotal = int.parse(rateController.text) * sell.kg;
      }
      if (selling != null) {
        dtotal = int.parse(rateController.text) * selling.kg;
      }
    }

    totalAmount.value = dtotal.round();
  }

  selectedForUpdate(Selling selling) {
    billnoController.text = selling.billno ?? '';
    rateController.text = selling?.rate.toString() ?? 0.toString();
    travelController.text = selling?.travel.toString() ?? 0.toString();
    remarksController.text = selling.remarks ?? '';
    totalAmount.value = selling.total.round().toInt() ?? 0;
  }

  saveSelling(int challid, Sel sel) async {
    Selling selling = new Selling(
        challid: challid,
        billno: billnoController.text.isNotEmpty ? billnoController.text : '',
        piece: sel.qty,
        kg: sel.kg,
        rate:
            rateController.text.isNotEmpty ? int.parse(rateController.text) : 0,
        remarks:
            remarksController.text.isNotEmpty ? remarksController.text : '',
        travel: travelController.text.isNotEmpty
            ? int.parse(travelController.text)
            : 0,
        enterdate: DateFormat('yyyy-MM-dd ').parse(todayDate.value));

    int res = await sellingRepo.saveSelling(selling);
    if (res > 0) {
      Get.back();
      Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  updateSelling(int challid, Selling sel) async {
    Selling selling = new Selling(
        id: sel.id,
        challid: challid,
        billno: billnoController.text.isNotEmpty ? billnoController.text : '',
        piece: sel.piece,
        kg: sel.kg,
        rate:
            rateController.text.isNotEmpty ? int.parse(rateController.text) : 0,
        remarks:
            remarksController.text.isNotEmpty ? remarksController.text : '',
        travel: travelController.text.isNotEmpty
            ? int.parse(travelController.text)
            : 0,
        enterdate: sel.enterdate);

    int res = await sellingRepo.updateSelling(selling);
    if (res > 0) {
      Get.back();
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
