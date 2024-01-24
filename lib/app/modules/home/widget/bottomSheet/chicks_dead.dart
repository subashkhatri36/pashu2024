import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/add_chicks_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class ChickDead extends StatelessWidget {
  const ChickDead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChicksRecordController>();
    final hcontrol = Get.find<HomeController>();
    return BorderContainer(
        widget: SingleChildScrollView(
            child: Form(
      key: controller.formkey,
      child: Column(
        children: [
          Text(
            chick.tr + ' ' + dead.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.2,
            ),
          ),
          CustomTextField(
            validator: (value) => validateIsEmpty(string: value),
            controller: controller.deadqtyController,
            round: true,
            hintText: chick.tr,
            keyboardtype: TextInputType.number,
          ),
          CustomTextField(
            validator: (value) => validateIsEmpty(string: value),
            controller: controller.remarksController,
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
                      if (hcontrol.isInterstitialAdReady) {
                        hcontrol.interstitialAd?.show();
                      }
                      double cost = 0;
                      if (hcontrol.totalChalla.value != 0)
                        cost = ((hcontrol.totalExpenditure.value -
                                hcontrol.totalIncome.value) /
                            (hcontrol.totalChalla.value));
                      print(cost.round().toInt().abs());

                      await controller.addchallDead(cost.round().toInt().abs(),
                          context, hcontrol.challid.value);
                      hcontrol.deadchallList = await hcontrol.deadChallaRepo
                          .getChallaDead(hcontrol.challid.value);
                      hcontrol.sumofDeadChick();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
