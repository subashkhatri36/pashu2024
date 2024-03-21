import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/labour_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class AddLabor extends StatelessWidget {
  const AddLabor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chickController = Get.find<HomeController>();
    final controller = Get.find<LaborController>();
    controller.loadLabor(chickController.challid.value);
    final hcontroller = Get.find<HomeController>();

    return BorderContainer(
        widget: SingleChildScrollView(
      child: Form(
        key: controller.formkey,
        child: Column(
          children: [
            Text(
              add.tr + ' ' + labor.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.rateController,
              round: true,
              hintText: rate.tr,
              keyboardtype: TextInputType.number,
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.remarkController,
              round: true,
              hintText: remark.tr,
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
                      label: controller.updatelabor ? update.tr : save.tr,
                      onPressed: () async {
                        if (!controller.updatelabor) {
                          await controller.savedLabor(
                              chickController.challid.value, context);
                        } else {
                          await controller.updateLabor(
                              chickController.challid.value, context);
                        }
                        await hcontroller.totalExpenses();
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
