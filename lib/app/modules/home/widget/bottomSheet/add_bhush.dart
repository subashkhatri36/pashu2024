import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/bhush_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class BhushAdd extends StatefulWidget {
  const BhushAdd({
    Key? key,
  }) : super(key: key);

  @override
  _BhushAddState createState() => _BhushAddState();
}

class _BhushAddState extends State<BhushAdd> {
  final controller = Get.find<BhushController>();
  final chickid = Get.find<HomeController>();
  //bool upd = false;
  // bool val; // = controller.loadBhush(chickid.challid.value);
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await controller.loadBhush(chickid.challid.value);
  }

  @override
  Widget build(BuildContext context) {
    final hcontroller = Get.find<HomeController>();
    return BorderContainer(
      widget: SingleChildScrollView(
          child: Obx(
        () => controller.isloading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: controller.formkey,
                child: Column(children: [
                  Text(
                    controller.updatebhus
                        ? update.tr + ' ' + bhus.tr
                        : add.tr + ' ' + bhus.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 1.2,
                    ),
                  ),
                  CustomTextField(
                    validator: (value) => validateIsEmpty(string: value),
                    controller: controller.qtyController,
                    round: true,
                    hintText: total.tr + ' ' + qty.tr + ' ' + use.tr,
                    keyboardtype: TextInputType.number,
                    onChange: (value) => controller.calculateBhus(),
                  ),
                  CustomTextField(
                    validator: (value) => validateIsEmpty(string: value),
                    controller: controller.rateController,
                    round: true,
                    hintText: rate.tr,
                    keyboardtype: TextInputType.number,
                    onChange: (value) => controller.calculateBhus(),
                  ),
                  CustomTextField(
                    validator: (value) => validateIsEmpty(string: value),
                    controller: controller.remarkController,
                    round: true,
                    hintText: remark.tr,
                    maxline: 5,
                    keyboardtype: TextInputType.text,
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
                              rs.tr +
                                  controller.totalAmount.value.toString() +
                                  '/-',
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
                            label: controller.updatebhus ? update.tr : save.tr,
                            onPressed: () async {
                              if (controller.updatebhus) {
                                await controller.updateBhush(
                                    chickid.challid.value, context);
                              } else {
                                await controller.savedBhush(
                                    chickid.challid.value, context);
                              }
                              await hcontroller.totalExpenses();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
      )),
    );
  }
}
