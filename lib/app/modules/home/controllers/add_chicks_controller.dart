import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/chall_record_respositiories.dart';
import 'package:pasuhisab/app/core/repositories/challa_dead_repositories.dart';
import 'package:pasuhisab/app/data/model/chall_dead.dart';
import 'package:pasuhisab/app/data/model/challa_record.dart';

class ChicksRecordController extends GetxController {
  DeadChallaRepo deadChallaRepo = new DeadChallaRepositories();
  ChallRecordRepo challrepo = new ChallRepositories();

  RxList<ChallaRecord> challRecordList =
      List<ChallaRecord>.empty(growable: true).obs;
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController billnoController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  RxString todayDate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;

  RxInt total = 0.obs;
  RxString categoryString = ''.obs;
  int challaId = 0;

  final list = <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      value: 'Edit',
      child: Text('Edit'),
    ),
    const PopupMenuItem<String>(
      value: 'Delete',
      child: Text('Choose value 2'),
    ),
    // const PopupMenuItem<String>(
    //   value: 'Value3',
    //   child: Text('Choose value 3'),
    // ),
  ];

  @override
  void onInit() {
    super.onInit();
    //loadChallRecord();
  }

  addChalla() async {
    if (formkey.currentState?.validate() ?? false) {
      if (categoryString.value != '') {
        ChallaRecord cr = new ChallaRecord(
            categoryid: categoryfindbyId(categoryString.value),
            billno: billnoController.text.isEmpty ? '' : billnoController.text,
            qty: int.parse(qtyController.text),
            rate: int.parse(rateController.text),
            total: total.value,
            enterdate: DateFormat('yyyy-MM-dd ').parse(todayDate.value));

        int result = await challrepo.saveChallRecord(cr);

        if (result > 0) {
          if (challRecordList != null) {
            cr.id = result;
            //challaId = cr.id;
            challRecordList.add(cr);
          } else {
            List<ChallaRecord> c = [];
            challaId = cr.id;
            c.add(cr);
            challRecordList = c.obs;
          }
          cleardata();
        }
      } else {
        Get.snackbar(error.tr, errorMessage.tr + ' Please Select category',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }
  }

  int categoryfindbyId(String id) {
    switch (id) {
      case boiler:
        return 1;
        break;
      case parent:
        return 2;
        break;
      case bhale:
        return 3;
        break;
      case turkey:
        return 4;
        break;
      case quail:
        return 5;
      case kadaknath:
        return 6;
        break;
      default:
        return 0;
        break;
    }
  }

  TextEditingController deadqtyController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();

  addchallDead(int cost, BuildContext context, int currentlot) async {
    ChallDead cd = new ChallDead(
        challid: currentlot,
        qty: int.parse(deadqtyController.text),
        price: cost,
        enterdate: DateTime.now());
    int res = await deadChallaRepo.saveChallDead(cd);
    if (res > 0) {
      Navigator.of(context).pop();
      cleardata();
      Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  // loadChallRecord() async {
  //   isloadingchalla.toggle();
  //   challRecordList.clear();
  //   List<ChallaRecord> cr = await challrepo.getChallRecord();

  //   if (cr != null && (cr?.length ?? 0) > 0) {
  //     challRecordList = cr.obs;
  //     challid.value = challRecordList[0].id;
  //   }
  //   isloadingchalla.toggle();
  // }

  calculatetotal() {
    if (rateController.text.isNotEmpty && qtyController.text.isNotEmpty) {
      total.value =
          int.parse(rateController.text) * int.parse(qtyController.text);
    } else {
      total.value = 0;
    }
  }

  @override
  void onReady() {
    super.onReady();
    // loadChallRecord();
  }

  cleardata() {
    billnoController.clear();
    qtyController.clear();
    rateController.clear();
    deadqtyController.clear();
    remarksController.clear();
  }

  @override
  void onClose() {
    billnoController.dispose();
    qtyController.dispose();
    rateController.dispose();
    deadqtyController.dispose();
    remarksController.dispose();
    super.onClose();
  }
}
