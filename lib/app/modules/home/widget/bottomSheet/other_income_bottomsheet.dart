import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/other.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/other_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class OtherIncome extends StatelessWidget {
  const OtherIncome({
    Key? key,
    this.inout = false,
    this.updateed = false,
    required this.model,
  }) : super(key: key);
  final bool inout;
  final bool updateed;
  final OtherModel model;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtherController>();
    // final chickController = Get.find<ChicksRecordController>();
    final hcontroller = Get.find<HomeController>();

    return BorderContainer(
        widget: SingleChildScrollView(
      child: Form(
        key: controller.formkey,
        child: Column(
          children: [
            Text(
              other.tr + ' ' + income.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.rateController,
              round: true,
              hintText: amount.tr,
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
                      label: save.tr,
                      onPressed: () async {
                        if (hcontroller.isInterstitialAdReady) {
                          hcontroller.interstitialAd?.show();
                        }
                        if (updateed) {
                          await controller.updateOtherModel(
                              inout, context, model);
                        } else {
                          await controller.savedOtherModel(
                              hcontroller.challid.value, inout, context);
                        }
                        await hcontroller.totalIncomeMethod();
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
