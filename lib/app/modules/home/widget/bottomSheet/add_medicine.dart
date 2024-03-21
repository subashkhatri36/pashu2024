import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/medicine_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({
    Key? key,
  }) : super(key: key);
  // final int challid;
  // final Medicine m;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MedicineController>();
    final chickcontroller = Get.find<HomeController>();
    final hcontroller = Get.find<HomeController>();
    controller.loadMedicine(chickcontroller.challid.value);
    return BorderContainer(
        widget: SingleChildScrollView(
      child: Form(
        key: controller.formkey,
        child: Column(
          children: [
            Text(
              controller.updatemedicine
                  ? update.tr + ' ' + medicine.tr
                  : add.tr + ' ' + medicine.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.rateController,
              round: true,
              hintText: total.tr + ' ' + amount.tr,
              keyboardtype: TextInputType.number,
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.remarkController,
              round: true,
              hintText: medicine.tr,
              maxline: 5,
              keyboardtype: TextInputType.text,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      borderRadius: borderRadius,
                      label: close.tr,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: SizeConfig.heightMultiplier / 2),
                  Expanded(
                    child: CustomButton(
                      borderRadius: borderRadius,
                      label: controller.updatemedicine ? update.tr : save.tr,
                      onPressed: () async {
                        await controller.savedMedicine(
                            chickcontroller.challid.value, context);
                        await hcontroller.totalExpenses();

                        // Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
