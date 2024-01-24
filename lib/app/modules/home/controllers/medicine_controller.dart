import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/medicine_repositiories.dart';
import 'package:pasuhisab/app/data/model/medicine.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class MedicineController extends GetxController {
  MedicineRepo medicineRepo = new MedicineRepositories();
  RxInt totalAmount = 0.obs;
  bool updatemedicine = false;
  RxBool isloading = false.obs;

  RxList<Medicine> medicineList = List<Medicine>.empty(growable: true).obs;
  // TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
//DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // qtyController.dispose();
    rateController.dispose();
    remarkController.dispose();
  }

  loadMedicine(int challid) async {
    isloading.toggle();

    var val = await medicineRepo.getAllMedicine(challid);

    if (val != null)
      for (var amount in val) {
        totalAmount.value += amount.total;
      }
    if (val != null) medicineList = val.obs;
    isloading.toggle();
  }

  cleardata() {
    rateController.text = '';
    remarkController.text = '';
  }

  savedMedicine(int challid, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      Medicine b = new Medicine(
          challid: challid,
          total: int.parse(rateController.text),
          remarks: remarkController.text,
          enterdate: DateTime.now());

      int a = await medicineRepo.saveMedicine(b);
      if (a > 0) {
        b.id = a;
        medicineList.add(b);

        Navigator.of(context).pop();
        cleardata();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  selectForUpdate(int total, String remark) {
    //  qtyController.text = currentMedicine.qty.toString();
    rateController.text = total.toString();
    remarkController.text = remark;
    //  totalAmount.value = currentMedicine.total;
  }

  updatemedicineh(Medicine m, int challid, BuildContext context) async {
    Medicine b = new Medicine(
        id: m.id,
        challid: challid,
        total: int.parse(rateController.text),
        // qty: int.parse(qtyController.text),
        remarks: remarkController.text,
        enterdate: DateTime.now());

    int update = await medicineRepo.updateMedicine(b);
    if (update > 0) {
      medicineList.remove(m);
      medicineList.add(b);
      Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      Navigator.pop(context);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  deleteMedicine(Medicine m, BuildContext context) async {
    bool result = await dialogBox(context,
        title: 'Warning !',
        message: 'Are you sure to delete this this medicine ?',
        btnname: 'Delete');
    if (result) {
      int i = await medicineRepo.deleteMedicine(m.id);
      if (i > 0) {
        medicineList.remove(m);
        Get.snackbar(info.tr, deleteMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }
}
