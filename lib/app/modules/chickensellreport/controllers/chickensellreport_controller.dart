import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/selling_repositiories.dart';
import 'package:pasuhisab/app/data/model/chall_selling_record.dart';

class ChickensellreportController extends GetxController {
  SellingRepo sellingRepo = new SellingRepositories();
  List<String> menulist = ['Edit', 'Delete'];

  RxString todayDate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;

  RxInt totalQty = 0.obs;
  RxDouble totalKg = 0.0.obs;
  RxDouble maxAverage = 0.0.obs;
  RxInt maxRate = 0.obs;
  RxInt totalAmount = 0.obs;
  RxInt travelcost = 0.obs;
  RxBool isloading = false.obs;
  RxList<Selling> sellinglist = List<Selling>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
  }

  int? challids;

  loadingSelling(int challid) async {
    challids = challid;
    isloading.toggle();
    totalQty.value = 0;
    totalKg.value = 0;
    maxAverage.value = 0;
    maxRate.value = 0;
    totalAmount.value = travelcost.value = 0;
    List<Selling> datalist = await sellingRepo.getAllSelling(challid);

    List<Selling> sellenew = [];
    if (datalist != null) {
      List<double> averagelis = [];
      List<int> ratelist = [];
      datalist.forEach((element) {
        double av = element.kg / element.piece;
        double d = element.kg * element.rate;
        Selling se = element;
        se.total = d;
        se.average = av;
        sellenew.add(se);

        averagelis.add(av);
        ratelist.add(element.rate);

        totalAmount.value += int.parse(d.round().toString());
        totalKg.value += element.kg;
        totalQty.value += element.piece;
        travelcost.value += element.travel;
      });
      //averagelis.map((e) => e.rate).toSet().toList();

      var averagedistinct = averagelis.toSet().toList();
      var ratedistinct = ratelist.toSet().toList();
      if (averagedistinct.length > 0 && averagedistinct != null)
        maxAverage.value = averagedistinct.reduce(max);
      else
        maxAverage.value = averagedistinct[0];
      if (ratedistinct.length > 0 && ratedistinct != null)
        maxRate.value = ratedistinct.reduce(max);
      else
        maxRate.value = 0;

      totalAmount.value = totalAmount.value - travelcost.value;

      if (sellenew != null) sellinglist = sellenew.obs;
    }

    isloading.toggle();
  }

  deleteChickenReport(int id, int index) async {
    int res = await sellingRepo.deleteSelling(id);
    if (res > 0) {
      Get.snackbar(info.tr, deleteMessage.tr, backgroundColor: Colors.white);

      if (index == 1)
        sellinglist.removeAt(0);
      else
        sellinglist.removeAt(index);
    } else {
      Get.snackbar(info.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
    loadingSelling(challids ?? 0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
