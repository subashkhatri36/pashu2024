import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/core/repositories/other_repositories.dart';
import 'package:pasuhisab/app/data/model/other.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class OtherController extends GetxController {
  OtherRepo otherRepo = new OtherRepositories();
  // RxInt totalAmount = 0.obs;
  bool updateOther = false;
  // OtherModel other;

  // TextEditingController qtyController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  String todaydate =
      DateFormat('yyyy-MM-dd ').format(DateTime.now()).toString();
  List<OtherModel> otherlist = [];
  RxBool isloading = false.obs;

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

  loadOtherModel(int challid, bool inout) async {
    isloading.toggle();
    List<OtherModel> val = await otherRepo.getAllOtherModel(challid, inout);

    if (val != null) otherlist = val.obs;
    isloading.toggle();
  }

  savedOtherModel(int challid, bool inout, BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      OtherModel b = new OtherModel(
          inout: inout,
          challid: challid,
          remarks: remarkController.text,
          total: int.parse(rateController.text),
          enterdate: DateTime.now());

      int a = await otherRepo.saveOtherModel(b);
      if (a > 0) {
        cleardata();
        Navigator.of(context).pop();
        Get.snackbar(info.tr, saveMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  cleardata() {
    rateController.text = '';
    remarkController.text = '';
  }

  selectForUpdate(OtherModel other) {
    // qtyController.text = egg.qty.toString();
    rateController.text = other.total.toString();
    remarkController.text = other.remarks;
    //  totalAmount.value = egg.total;
  }

  updateOtherModel(bool inout, BuildContext context, OtherModel model) async {
    OtherModel b = new OtherModel(
        inout: inout,
        id: model.id,
        challid: model.challid,
        remarks: remarkController.text,
        total: int.parse(rateController.text),
        enterdate: DateTime.now());

    var update = await otherRepo.updateOtherModel(b);
    if (update > 0) {
      otherlist.remove(model);
      otherlist.add(b);
      cleardata();
      Navigator.of(context).pop();
      Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
    } else {
      Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
    }
  }

  deleteOtherModel(
    int id,
    BuildContext context,
  ) async {
    bool d = await dialogBox(context,
        title: 'Warning !',
        message: 'Are you Sure do you want to delete.?',
        btnname: 'Delete');
    if (d) {
      int i = await otherRepo.deleteOtherModel(id);
      if (i > 0) {
        otherlist.remove(d);
        Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }
}
