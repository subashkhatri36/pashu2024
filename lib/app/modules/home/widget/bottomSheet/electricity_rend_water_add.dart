import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/electricity_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class EleRentWater extends StatelessWidget {
  const EleRentWater({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ElectricityController>();
    //  final chickcontroller = Get.find<ChicksRecordController>();
    final hcontroller = Get.find<HomeController>();
    controller.loadEleModel(hcontroller.challid.value);

    return BorderContainer(
        widget: SingleChildScrollView(
      child: Form(
        key: controller.formkey,
        child: Column(
          children: [
            Text(
              add.tr + ' ' + electricity.tr + ',' + water.tr + ' ' + rent.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              onChange: (value) => controller.calculatetotal(),
              controller: controller.electricityController,
              round: true,
              hintText: electricity.tr + ' ' + cost.tr,
              keyboardtype: TextInputType.number,
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              onChange: (value) => controller.calculatetotal(),
              controller: controller.rentController,
              round: true,
              hintText: rent.tr + ' ' + cost.tr,
              keyboardtype: TextInputType.number,
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              onChange: (value) => controller.calculatetotal(),
              controller: controller.waterController,
              round: true,
              hintText: water.tr + ' ' + cost.tr,
              keyboardtype: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: borderRadius / 2,
                vertical: borderRadius / 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    total.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Text(
                        rs.tr + controller.totalAmount.value.toString() + '/-',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
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
                      label: controller.updateElect ? update.tr : save.tr,
                      onPressed: () async {
                        if (hcontroller.isInterstitialAdReady) {
                          hcontroller.interstitialAd?.show();
                        }
                        if (controller.updateElect) {
                          await controller.updateEleModel(
                              hcontroller.challid.value, context);
                        } else {
                          await controller.savedEleModel(
                              hcontroller.challid.value, context);
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
