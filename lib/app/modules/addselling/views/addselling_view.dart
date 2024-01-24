import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/chall_selling_record.dart';
import 'package:pasuhisab/app/data/model/sel_model.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/date_widget.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

import '../controllers/addselling_controller.dart';

class AddsellingView extends GetView<AddsellingController> {
  final arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    Sel sell = arg[0];
    if (sell == null)
      controller.updateded = true;
    else
      controller.updateded = false;
    String data = arg[1].toString().toLowerCase();

    Selling selling = arg[2];
    if (data.toLowerCase() != 'add') controller.selectedForUpdate(selling);

    //  final chickcontroller = Get.find<ChicksRecordController>();
    final hcontroller = Get.find<HomeController>();
    final splash = Get.find<SplashController>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add/Update Details'),
        ),
        body: BorderContainer(
          widget: SingleChildScrollView(
            child: Form(
              key: controller.formkey,
              child: Column(
                children: [
                  DateWidget(
                      controller: controller,
                      nepalidate: splash.dateNepali.value),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller.billnoController,
                          round: true,
                          hintText: billno.tr,
                          keyboardtype: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.rateController,
                          round: true,
                          hintText: rate.tr,
                          keyboardtype: TextInputType.number,
                          onChange: (change) => controller.calculatetotal(
                              selling: selling, sell: sell),
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    controller: controller.travelController,
                    round: true,
                    hintText: travel.tr,
                    keyboardtype: TextInputType.number,
                  ),
                  CustomTextField(
                    controller: controller.remarksController,
                    round: true,
                    hintText: remark.tr,
                    maxline: 5,
                    keyboardtype: TextInputType.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(borderRadius / 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              qty.tr,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.2),
                            ),
                            Text(
                              data.toLowerCase() != 'add'
                                  ? selling.piece.toString()
                                  : sell.qty.toString(),
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.2),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              kg.tr,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.2),
                            ),
                            Text(
                              data.toLowerCase() != 'add'
                                  ? selling.kg.toStringAsFixed(2)
                                  : sell.kg.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(borderRadius / 3),
                    child: Obx(() => Text(
                          total.tr +
                              ' ' +
                              amount.tr +
                              ' ' +
                              rs.tr +
                              controller.totalAmount.value.toString() +
                              '/-',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.2),
                        )),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          borderRadius: borderRadius,
                          label: cancel.tr,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(width: SizeConfig.heightMultiplier / 2),
                      Expanded(
                        child: CustomButton(
                          borderRadius: borderRadius,
                          label: controller.updateded ? update.tr : save.tr,
                          onPressed: () async {
                            if (hcontroller.isInterstitialAdReady) {
                              hcontroller.interstitialAd?.show();
                            }
                            if (controller.updateded) {
                              await controller.updateSelling(
                                  hcontroller.challid.value, selling);
                            } else {
                              await controller.saveSelling(
                                  hcontroller.challid.value, sell);
                            }
                            await hcontroller.totalIncomeMethod();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
