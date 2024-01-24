import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/danaConsumption_repositories.dart';
import 'package:pasuhisab/app/core/repositories/dana_repositories.dart';
import 'package:pasuhisab/app/data/model/dana_consumption.dart';
import 'package:pasuhisab/app/data/model/dana_record.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class DanaController extends GetxController {
  List<String> menulist = ['Edit', 'Return', 'Delete'];
  int colorindex = 0;
  List<Color> colors = const [
    Colors.black,
    Colors.red,
    Colors.redAccent,
    Colors.red,
    Colors.redAccent
  ];
  DanaRepo danaRepo = new DanaRepositiories();
  DanaConsumeRepo danaConsumeRepo = new DanaConsumeRepositories();
  RxString selectedDana = 'B0'.obs;
  RxInt totalamount = 0.obs;
  RxString todayDate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;
  final formkey = new GlobalKey<FormState>();
  TextEditingController billnoController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();

  TextEditingController conqtyController = new TextEditingController();
  final scroll = new ScrollController();

  RxBool isloading = false.obs;
  RxList<Dana> danaMainList = List<Dana>.empty(growable: true).obs;
  RxInt totalDana = 0.obs;
  RxInt totalsum = 0.obs;
  int id = 0;
  RxBool updateTable = false.obs;

  //calculating sums
  double position = 0;
  double currentposition = 0;
  @override
  void onInit() {
    super.onInit();
    scroll.addListener(() {
      position = scroll.position.pixels;
    });
  }

  void scrollToTop() {
    scroll.animateTo(0, duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void currentPostion() {
    currentposition = position;
  }

  void gobacktoposition() {
    scroll.animateTo(currentposition,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  void onReady() {
    super.onReady();
  }

  List<Dana> b0 = List<Dana>.empty(growable: true).obs;
  List<Dana> b1 = List<Dana>.empty(growable: true).obs;
  List<Dana> b2 = List<Dana>.empty(growable: true).obs;
  List<Dana> l3 = List<Dana>.empty(growable: true).obs;

  addConsumption(int challid, int dana, int index, BuildContext context) async {
    if (conqtyController.text.isNotEmpty) {
      currentPostion();
      int dif = danaMainList[index].qty - (danaMainList[index].consume ?? 0);
      if (dif > 0) {
        if (int.parse(conqtyController.text) <= dif) {
          DanaConsumption dc = new DanaConsumption(
              challid: challid,
              dana: dana,
              qty: int.parse(conqtyController.text),
              enterdate: DateFormat('yyyy-MM-dd ').parse(todayDate.value));
          int save = await danaConsumeRepo.savedanaConsumption(dc);
          if (save > 0) {
            if (danaMainList[index].consume == null)
              danaMainList[index].consume = 0;
            danaMainList[index].consume += int.parse(conqtyController.text);
            gobacktoposition();
          }
          conqtyController.text = '';
          navigator?.pop(context);
        } else {
          Get.snackbar(error.tr, 'Enter valid qty',
              backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar(error.tr, 'No quantity left',
            backgroundColor: Colors.white);
      }
    }
  }

  getAllDana(int challid) async {
    isloading.toggle();
    totalDana.value = 0;
    totalsum.value = 0;
    List<Dana> b01 = [];
    List<Dana> b02 = [];
    List<Dana> b03 = [];
    List<Dana> l1 = [];

    b0.clear();
    b1.clear();
    b2.clear();
    l3.clear();
    List<Dana> danalist = await danaRepo.getAllDana(challid);
    if (danalist != null)
      for (var element in danalist) {
        if (element.dana == 'B0')
          b01.add(element);
        else if (element.dana == 'B1')
          b02.add(element);
        else if (element.dana == 'B2')
          b03.add(element);
        else if (element.dana == 'L3') l1.add(element);
      }
    if (danalist != null)
      danalist.forEach((element) async {
        totalDana.value += element.qty;
        totalsum.value += element.qty * element.rate;
        element.consume = await getDanaConsume(id: element.id);
      });
    if (danalist != null) danaMainList = danalist.obs;
    filterDana(b01, b02, b03, l1);
    isloading.toggle();
  }

  void filterDana(
      List<Dana> b01, List<Dana> b02, List<Dana> b03, List<Dana> l1) {
    var b0distinct = b01.map((e) => e.rate).toSet().toList();
    var b1distinct = b02.map((e) => e.rate).toSet().toList();
    var b2distinct = b03.map((e) => e.rate).toSet().toList();
    var l3distinct = l1.map((e) => e.rate).toSet().toList();

    if ((b0distinct?.length ?? 0) > 0) {
      List<Dana> a = seprateandCalculateAll(
        dana: 'B0',
        distinctlist: b0distinct,
        list: b01,
      );

      b0 = a.obs;
    }

    if ((b1distinct?.length ?? 0) > 0)
      b1 = seprateandCalculateAll(
        dana: 'B1',
        distinctlist: b1distinct,
        list: b02,
      );
    if ((b2distinct?.length ?? 0) > 0)
      b2 = seprateandCalculateAll(
        dana: 'B2',
        distinctlist: b2distinct,
        list: b03,
      );
    if ((l3distinct?.length ?? 0) > 0)
      l3 = seprateandCalculateAll(
        dana: 'L3',
        distinctlist: l3distinct,
        list: l1,
      );
  }

  Future<int> getDanaConsume({int? id}) async {
    int totalconsumtion = await danaConsumeRepo.countdanaConsumption(id ?? 0);
    return totalconsumtion;
  }

  seprateandCalculateAll(
      {required dynamic distinctlist,
      required dynamic list,
      required String dana}) {
    List<Dana> d = [];

    distinctlist.forEach((element) {
      var qty = calculate(list: list, rate: element);
      Dana di = new Dana(
        dana: dana,
        rate: element,
        qty: qty,
        total: (qty * element) as int ?? 0,
        billno: '',
        challid: 0,
        enterdate: DateTime.now(),
      );

      d.add(di);
    });
    return d;
  }

  int calculate({dynamic list, int? rate}) {
    int qty = 0;

    for (var e in list) {
      if (rate == e.rate) {
        qty += e.qty as int;
      }
    }

    return qty;
  }

  clearData() {
    billnoController.text = '';
    qtyController.text = '';
    rateController.text = '';
    totalamount.value = 0;
    selectedDana.value = 'B0';
  }

  selectedForUpdate(Dana dana) {
    currentPostion();
    todayDate.value =
        DateFormat('yyyy-MM-dd ').format(dana.enterdate).toString();
    qtyController.text = dana.qty.toString();
    rateController.text = dana.rate.toString();
    totalamount.value = dana.qty + dana.rate;
    billnoController.text = dana.billno;
    selectedDana.value = dana.dana;
    id = dana.id;
    updateTable.value = true;
    scrollToTop();

    //Get.dialog(DanaAdd(update: true));
  }

  deleteDana(BuildContext context, {required int id, int index = 0}) async {
    currentPostion();
    bool result = await dialogBox(context,
        title: 'Warning !',
        message:
            'Are you sure to delete this Dana All Consumption result also deleted?',
        btnname: 'Delete');
    if (result) {
      int res = await danaRepo.deleteDana(id);

      if (res > 0) {
        getAllDana(danaMainList[0].challid);
        gobacktoposition();
        Get.snackbar(info.tr, deleteMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  updateReturn(int challid, int index, context) async {
    currentPostion();
    Dana d = danaMainList[index];
    int dif = d.qty - (d.consume ?? 0);
    if (dif > 0) {
      if (int.parse(conqtyController.text) <= dif) {
        d.dreturn = int.parse(conqtyController.text);
        int res = await danaRepo.updateDana(d);
        if (res > 0) {
          getAllDana(challid);
          clearData();
          gobacktoposition();
          updateTable.value = false;
          navigator?.pop(context);
          Get.snackbar(info.tr, updateMessage.tr,
              backgroundColor: Colors.white);
        } else {
          Get.snackbar(error.tr, errorMessage.tr,
              backgroundColor: Colors.white);
        }
      }
    }
  }

  updateDana({required int challid}) async {
    Dana d = new Dana(
        id: id,
        dana: selectedDana.value,
        challid: challid,
        billno: billnoController.text == null ? '' : billnoController.text,
        qty: int.parse(qtyController.text),
        rate: int.parse(rateController.text),
        enterdate: DateFormat('yyyy-MM-dd ').parse(todayDate.value));

    await danaConsumeRepo.deletedanaConsumption(id);
    int res = await danaRepo.updateDana(d);
    if (res > 0) {
      getAllDana(challid);
      clearData();
      gobacktoposition();
      updateTable.value = false;
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  addDana({required challid}) async {
    if (formkey.currentState?.validate() ?? false) {
      if (selectedDana.value != null) {
        Dana d = new Dana(
            dana: selectedDana.value,
            challid: challid,
            billno: billnoController.text == null ? '' : billnoController.text,
            qty: int.parse(qtyController.text),
            rate: int.parse(rateController.text),
            enterdate: DateFormat('yyyy-MM-dd ').parse(todayDate.value));

        int res = await danaRepo.saveDana(d);
        if (res > 0) {
          d.id = res;
          danaMainList.add(d);
          clearData();
          Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
        } else {
          Get.snackbar(error.tr, errorMessage.tr,
              backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar(warning.tr, errorMessage.tr + ' Select Dana Type');
      }
    }
  }

  calculateTotal() {
    if (qtyController.text.isNotEmpty && rateController.text.isNotEmpty) {
      totalamount.value =
          int.parse(qtyController.text) * int.parse(rateController.text);
    } else {
      totalamount.value = 0;
    }
  }

  @override
  void onClose() {
    billnoController.dispose();
    qtyController.dispose();
    rateController.dispose();
    conqtyController.dispose();
  }
}
