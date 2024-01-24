import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/data/model/chall_selling_record.dart';
import 'package:pasuhisab/app/data/model/sel_model.dart';
import 'package:pasuhisab/app/modules/addselling/bindings/addselling_binding.dart';
import 'package:pasuhisab/app/modules/addselling/views/addselling_view.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class ChickensellController extends GetxController {
  RxList<Sel> sellinglist = List<Sel>.empty(growable: true).obs;
  RxDouble average = 0.0.obs;
  RxInt qty = 0.obs;
  RxDouble kg = 0.0.obs;
  Sel s = Sel(qty: 0, kg: 0);
  RxString todayDate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;

  GlobalKey<FormState> formey = new GlobalKey<FormState>();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController kgController = new TextEditingController();
  //TextEditingController rateController = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  clearData() {
    qtyController.text = '';
    kgController.text = '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  removeFromList(int index) {
    Sel s = sellinglist[index];
    // List<Sel> sel = sellinglist;
    // sel.remove(s);
    // sellinglist = sel.obs;

    sellinglist.remove(s);
    calculateAverage();
  }

  saveContinue(BuildContext context) async {
    if (qty.value > 0) {
      Sel s = new Sel(qty: qty.value, kg: kg.value);
      //saving
      bool info = await dialogBox(context,
          title: 'Info ',
          message: 'Is your information Correct \n Please proceed.',
          btnname: 'Ok');
      if (info) {
        //Saved to database with info

        Selling? selling;
        Get.to(() => AddsellingView(),
            binding: AddsellingBinding(), arguments: [s, 'add', selling]);
      }
    }
  }

  calculateAverage() {
    qty.value = 0;
    kg.value = 0.0;

    for (var l in sellinglist) {
      qty.value += l.qty;
      kg.value += l.kg;
    }
    average.value = kg.value / qty.value;
  }

  addData() {
    if (formey.currentState?.validate() ?? false) {
      Sel s = new Sel(
          qty: int.parse(qtyController.text),
          kg: double.parse(kgController.text));
      sellinglist.add(s);
      calculateAverage();
      clearData();
    }
  }

  @override
  void onClose() {
    qtyController.dispose();
    kgController.dispose();
  }
}
